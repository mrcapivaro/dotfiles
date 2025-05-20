local conditions = require("heirline.conditions")
local colors = require("gruvbox").palette

-- Widgets
-- Mode {{{

local Mode = {
    provider = function(self)
        return string.format("[%s] ", self.mode_names[self.mode])
    end,

    init = function(self)
        self.mode = vim.fn.mode(1)
    end,

    static = {
        mode_names = {
            n = "N.",
            no = "O.",
            nov = "Ov",
            noV = "O_",
            ["no\22"] = "O^",
            niI = "In",
            niR = "Ir",
            niV = "I_",
            v = "V.",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["\22"] = "V^",
            ["\22s"] = "V^",
            s = "S.",
            S = "S_",
            ["\19"] = "S^",
            i = "I.",
            ic = "Ic",
            ix = "Ix",
            R = "R.",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C.",
            cv = "Ex",
            r = "...",
            rm = "M.",
            ["r?"] = "?.",
            ["!"] = "Sh",
            t = "T.",
            nt = "Tn",
        },

        mode_colors = {
            n = colors.light0,
            i = colors.bright_blue,
            v = colors.bright_green,
            V = colors.bright_green,
            ["\22"] = colors.bright_green,
            c = colors.bright_orange,
            s = colors.bright_green,
            S = colors.bright_green,
            ["\19"] = colors.bright_green,
            R = colors.bright_aqua,
            r = colors.bright_aqua,
            ["!"] = colors.bright_red,
            t = colors.bright_red,
        },
    },

    hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], bold = true }
    end,

    update = {
        "ModeChanged",
        pattern = "*",
        callback = vim.schedule_wrap(function(self)
            self.mode = vim.fn.mode(1)
            vim.cmd("redrawstatus")
        end),
    },
}

-- }}}
-- File Diffs {{{

local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    ---Git Branch Name
    {
        provider = function(self)
            return "[ " .. self.status_dict.head .. "]"
        end,
    },

    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count .. " ")
        end,
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count .. " ")
        end,
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ") ",
    },
}

local FileDiffs = {
    Git,
    {
        condition = function()
            return not conditions.is_git_repo()
        end,
        provider = "%m ",
    },
}

-- }}}
-- Navic {{{

local Navic = {

    -- Evaluate the children containing navic components.
    provider = function(self)
        local Navic = self.child:eval()
        if Navic == "" or not Navic then
            return
        end
        -- BUG: Characters after 'Navic' get their background wrongly
        -- highlighted for some reason.
        return Navic
    end,

    update = "CursorMoved",

    condition = function()
        return vim.bo.filetype ~= "css" and require("nvim-navic").is_available()
    end,

    static = {
        -- Stackoverflow: Encode and Decode needed data with binary operations.
        -- line:  16 bit (65535)
        -- col:   10 bit (1023)
        -- winnr: 6 bit (63)
        enc = function(line, col, winnr)
            return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,

        dec = function(encoded)
            local line = bit.rshift(encoded, 16)
            local col = bit.band(bit.rshift(encoded, 6), 1023)
            local winnr = bit.band(encoded, 63)
            return line, col, winnr
        end,
    },

    init = function(self)
        local children = {}
        local data = require("nvim-navic").get_data() or {}
        -- Create a child for each level.
        for i = 1, #data do
            local d = data[i]
            -- Encode line and column numbers into a single integer.
            local pos = self.enc(
                d.scope.start.line,
                d.scope.start.character,
                self.winnr
            )
            local child = {
                { provider = d.icon },
                {
                    -- Escape '%s' from elixir and buggy default separators.
                    provider = d.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ""),
                    on_click = {
                        name = "heirline_navic",
                        -- Pass the encoded position through minwid.
                        minwid = pos,
                        callback = function(_, minwid)
                            -- decode
                            local line, col, winnr = self.dec(minwid)
                            vim.api.nvim_win_set_cursor(
                                vim.fn.win_getid(winnr),
                                { line, col }
                            )
                        end,
                    },
                },
            }
            -- add a separator only if needed
            if #data > 1 and i < #data then
                table.insert(child, { provider = " > " })
            end
            table.insert(children, child)
        end
        -- Instantiate the new child, overwriting the previous one.
        self.child = self:new(children, 1)
    end,

}

-- }}}
-- File Metadata {{{

local FileSize = {
    provider = function()
        local FileSize
        -- Stackoverflow: Compute human readable file size.
        local suffixes = { 'b', 'k', 'M', 'G', 'T', 'P', 'E' }
        local file_size = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
        file_size = (file_size < 0 and 0) or file_size
        local i = math.floor((math.log(file_size) / math.log(1024)))
        if file_size < 1024 then
            FileSize = file_size..suffixes[1]
        else
            FileSize = string.format(
                "%.2g%s",
                file_size / math.pow(1024, i),
                suffixes[i + 1]
            )
        end
        return string.format(" [%s]", FileSize)
    end
}

local FileEncoding = {
    provider = function()
        local FileEncoding
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
        FileEncoding = enc ~= 'utf-8' and enc:upper()
        return FileEncoding and string.format(" [%s]", FileEncoding)
    end,
}

local FileFormat = {
    provider = function()
        local FileFormat
        local fmt = vim.bo.fileformat
        FileFormat = fmt ~= 'unix' and fmt:upper()
        return FileFormat and string.format(" [%s]", FileFormat)
    end,
}

local FileMetadataBlock = {
    FileSize,
    FileEncoding,
    FileFormat,
}

-- }}}
-- Position {{{

local Position = {
    provider = " [%l:%c|%p%%]",
    hl = { fg = colors.light0, bold = true },
}

-- }}}

return {
    -- Default Highlights
    hl = { bg = colors.dark0, fg = colors.light4 },

    -- Left Side Widgets
    Mode,
    FileDiffs,
    Navic,

    -- Right Side Widgets
    { provider = "%=" },
    FileMetadataBlock,
    Position,
}

local string = string

local utils = require("heirline.utils")
local colors = require("gruvbox").palette

-- Files {{{

local Cwd = {
    condition = function()
        return vim.bo.buftype ~= "help"
    end,

    provider = function(self)
        return self.cwd
    end,

    hl = { fg = colors.light4 },
}

local FileName = {
    provider = function(self)
        return self.filename
    end,

    hl = { fg = colors.light0, bold = true },
}

local FileType = {
    -- condition = function(self)
    --     self.filetype = vim.bo.filetype
    --     return self.filetype ~= vim.fn.fnamemodify(self.filename, ":e")
    -- end,

    provider = " %y",

    hl = { fg = colors.light4 },
}

local FileBlock = {
    init = function(self)
        self.cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~") .. "/"
        self.filename = vim.fn.expand("%:p:~")

        if not self.filename or self.filename == "" then
            self.filename = "No Name"
        elseif string.find(self.filename, self.cwd) then
            self.filename = vim.fn.fnamemodify(self.filename, ":.")
        else
            self.cwd_start, self.cwd_end = string.find(self.filename, ".*/")
            self.cwd = string.sub(self.filename, self.cwd_start, self.cwd_end)
            self.filename =
                string.sub(self.filename, self.cwd_end + 1, #self.filename)
        end
    end,

    hl = { fg = colors.light0, bold = true },

    { provider = "[" },
    Cwd,
    FileName,
    FileType,
    { provider = "]" },
}

-- }}}
-- Buffers {{{

local BufferStatusIcon = {
    static = {
        icons = { inactive = "◯", active = "●" },
        hl = { inactive = colors.light4, active = colors.light0 },
    },

    provider = function(self)
        local icon = self.is_active and self.icons.active or self.icons.inactive
        return " " .. icon
    end,

    hl = function(self)
        return { fg = self.is_active and self.hl.active or self.hl.inactive }
    end
}

local BufferLine = utils.make_buflist(BufferStatusIcon)

local BufferBlock = {
    condition = function()
        return vim.bo.filetype ~= "help"
    end,
    hl = { fg = colors.light0 },
    provider = "",
    BufferLine,
    { provider = " " },
}

-- }}}

return {
    hl = { fg = colors.light4, bg = colors.dark0, sp = colors.bright_green },

    FileBlock,
    { provider = "%=" },
    BufferBlock,
}

-- ~/.config/nvim/init.lua

--{{{1 Options
---User Interace
vim.g.FloatBorders = "single" -- { "┌", "─", "┐", "│", "┘", "─", "└", "│" }

--{{{2 Statusline
-- -- Inspired from: https://github.com/MariaSolOs/dotfiles/blob/mac/.config/nvim/lua/statusline.lua
-- local mode_name = function()
--     local mode = vim.api.nvim_get_mode().mode
--     local mode_alias = {
--         ["n"] = "Normal",
--         ["no"] = "Op-Pending",
--         ["nov"] = "Op-Pending",
--         ["noV"] = "Op-Pending",
--         ["no\22"] = "Op-Pending",
--         ["niI"] = "Normal",
--         ["niR"] = "Normal",
--         ["niV"] = "Normal",
--         ["nt"] = "Normal",
--         ["ntT"] = "Normal",
--         ["v"] = "Visual",
--         ["vs"] = "Visual",
--         ["V"] = "Visual",
--         ["Vs"] = "Visual",
--         ["\22"] = "Visual",
--         ["\22s"] = "Visual",
--         ["s"] = "Select",
--         ["S"] = "Select",
--         ["\19"] = "Select",
--         ["i"] = "Insert",
--         ["ic"] = "Insert",
--         ["ix"] = "Insert",
--         ["R"] = "Replace",
--         ["Rc"] = "Replace",
--         ["Rx"] = "Replace",
--         ["Rv"] = "Virt Replace",
--         ["Rvc"] = "Virt Replace",
--         ["Rvx"] = "Virt Replace",
--         ["c"] = "Command",
--         ["cv"] = "Vim Ex",
--         ["ce"] = "Ex",
--         ["r"] = "Prompt",
--         ["rm"] = "More",
--         ["r?"] = "Confirm",
--         ["!"] = "Shell",
--         ["t"] = "Terminal",
--     }
--     local hl = "Normal"
--     if mode_alias[mode] == "Insert" then
--         hl = "Insert"
--     elseif mode_alias[mode] == "Visual" then
--         hl = "Visual"
--     elseif mode_alias[mode] == "Command" then
--         hl = "Command"
--     end
--     return table.concat({
--         "%#" .. "MiniStatuslineMode" .. hl .. "#",
--         " ",
--         mode_alias[mode] or mode,
--         " ",
--         "%#" .. "Statusline" .. "#",
--         " ",
--     })
-- end

-- local filetype = function()
--     local ok, icons = pcall(require, "nvim-web-devicons")
--     if not ok then
--         vim.notify("nvim-web-devicons not installed!", "WARN")
--     end
--     local ft = vim.fn.expand("%:e")
--     local icon = icons.get_icon_by_filetype(ft)
--     return (icon or "") .. " " .. ft .. " "
-- end

-- local current_file = function()
--     return vim.fn.expand("%")
-- end

-- local position = function()
--     local current_loc = vim.fn.line(".")
--     local current_coc = vim.fn.virtcol(".")
--     local total_loc = vim.fn.line("$")
--     local file_percentage = math.floor(current_loc / total_loc * 100)
--     return table.concat({
--         "%#" .. "MiniStatuslineModeNormal" .. "#",
--         " ",
--         current_loc .. ":" .. current_coc .. " " .. file_percentage .. "%%",
--         " ",
--         "%#" .. "Statusline" .. "#",
--         " ",
--     })
-- end

-- local encoding = function()
--     local encoding = vim.opt.fileencoding:get()
--     if encoding == "utf-8" then
--         return ""
--     end
--     return table.concat({
--         " ",
--         encoding,
--         " ",
--     })
-- end

-- local function gitsigns()
--     local status = vim.b.gitsigns_status_dict
--     if not status then
--         return ""
--     end
--     local changes = {
--         status.added and (status.added ~= 0) and ("+" .. status.added) or "",
--         status.removed and (status.removed ~= 0) and ("-" .. status.removed)
--             or "",
--         status.changed and (status.changed ~= 0) and ("~" .. status.changed)
--             or "",
--     }
--     return table.concat({
--         " ",
--         (" %s "):format(status.head),
--         table.concat(changes, " "),
--         " ",
--     })
-- end

-- ---@diagnostic disable-next-line: unused-local unused-function
-- local render = function()
--     return table.concat({
--         mode_name(),
--         gitsigns(),
--         "%=",
--         filetype(),
--         encoding(),
--         position(),
--     })
-- end

-- vim.o.statusline = "%!v:lua.require('statusline').render()"
--}}}

---Keymap Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.timeoutlen = 2000

---Listchars
vim.opt.listchars = { space = ".", tab = "> ", eol = "~" } -- ·␣¬»

vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.showmode = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "81"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.spelllang = { "en_US.UTF-8" }
vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 50
vim.opt.virtualedit = "block"
vim.opt.conceallevel = 2
vim.opt.cursorline = true

-- Conceal is normal and command mode, but not on the cursorline.
vim.opt.concealcursor:remove("n")

---Folding
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 0
vim.opt.foldcolumn = "auto:1"
vim.opt.fillchars:append("fold:-")

-- https://www.reddit.com/r/neovim/comments/1d3iwcz/custom_folds_without_any_plugins/
-- FoldText = function()
--     local foldend = vim.v.foldend
--     local foldstart = vim.v.foldstart
--     local raw = table.concat( vim.fn.getbufline(vim.api.nvim_get_current_buf(), foldstart), "")

--     local title = raw:match("{{{[0-9](.*)") -- }}}

--     local loc = foldend - foldstart
--     local level = raw:match("([0-9])")
--     title = ("*"):rep(level) .. title .. (" (%s) "):format(loc)

--     local fillerchar = "-"
--     local fillersize = 80 - #title - 1
--     title = title .. fillerchar:rep(fillersize)

--     return title
-- end

-- vim.o.foldtext = "v:lua.FoldText()"

--{{{2 Tools
local tools = {}

tools.lspconfig = {
    items = {
        "lua_ls",
        "html",
        "cssls",
        "emmet_ls",
        "clangd",
        "pyright",
        "ruff",
        -- "hls",
        "bashls",
        "ts_ls",
        "taplo",
    },
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
    handlers = {
        -- Default Handler
        function(server)
            local lspconfig = require("lspconfig")
            local capabilities = vim.tbl_deep_extend(
                "keep",
                require("cmp_nvim_lsp").default_capabilities(),
                lspconfig.util.default_config.capabilities
            )
            -- capabilities.textDocument.completion.completionItem.snippetSupport = true
            lspconfig[server].setup({
                capabilities = capabilities,
            })
        end,
        -- fix for the error `this document has been excluded`
        -- https://www.reddit.com/r/neovim/comments/1fkprp5/how_to_properly_setup_lspconfig_for_toml_files/
        ["taplo"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.taplo.setup({
                filetypes = { "toml" },
                root_dir = require("lspconfig.util").root_pattern(
                    "*.toml",
                    "*.git"
                ),
            })
        end,
        ["clangd"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup({
                cmd = {
                    "clangd",
                    "--enable-config",
                },
            })
        end,
        ["lua_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.lua_ls.setup({
                workspace = {
                    checkThirdParty = false,
                    library = vim.tbl_deep_extend(
                        "force",
                        vim.api.nvim_get_runtime_file("", true),
                        {
                            "/usr/share/awesome/lib",
                            "/usr/share/lua",
                        }
                    ),
                },
                diagnostics = {
                    globals = {
                        "awesome",
                        "awful",
                        "client",
                        "screen",
                        "tag",
                        "root",
                    },
                },
                telemetry = { enabled = false },
            })
        end,
    },
}

-- Formatters and Linters as LSPs
tools.null_ls = {
    items = {
        "stylua",
        "prettierd",
        "shfmt",
    },
    handlers = {
        shfmt = function(source_name, methods)
            require("mason-null-ls").default_setup(source_name, methods)
            local null_ls = require("null-ls")
            null_ls.register(null_ls.builtins.formatting.shfmt.with({
                extra_args = { "-i", "4", "-ci" },
            }))
        end,
        prettierd = function(source_name, _)
            -- require("mason-null-ls").default_setup(source_name, methods)
            local null_ls = require("null-ls")
            null_ls.register(null_ls.builtins.formatting[source_name].with({
                disabled_filetypes = { "html", "markdown" },
            }))
        end,
    },
}

tools.nvim_dap = {
    items = {
        "codelldb",
    },
    handlers = {},
}
--2}}}

--1}}}

--{{{1 Plugins

--{{{2 Plugin Manager
-- bootstrap plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local lazy_opts = {
    defaults = { lazy = false },
    install = { colorscheme = { "catppuccin", "habamax" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "netrw",
                "netrwPlugin",
                "netrwSettings",
                "netrwFileHandlers",
                "gzip",
                -- "tutor",
                "zip",
                "zipPlugin",
                "tar",
                "tarPlugin",
                "getscript",
                "getscriptPlugin",
                "vimball",
                "vimballPlugin",
                "2html_plugin",
                "logipat",
                "rrhelper",
                "spellfile_plugin",
                "matchit",
            },
        },
    },
}
--}}}

local plugins = {}

--{{{2 Quality of Life
table.insert(plugins, {
    {
        "mg979/vim-visual-multi",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = { ignore = "^$" },
    },

    {
        "barrett-ruth/live-server.nvim",
        cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
        keys = {
            {
                "<leader>ls",
                "<cmd>LiveServerToggle<cr>",
                desc = "Toggle Live Server",
            },
        },
        opts = function()
            local t = {}
            -- check for a WSL2 system
            if
                vim.fn.filereadable("/proc/sys/fs/binfmt_misc/WSLInterop") == 1
            then
                t = {
                    args = {
                        "--browser=wslview",
                    },
                }
            end
            return t
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = "VeryLazy",
        name = "colorizer",
        opts = {
            filetypes = {
                "css",
                "js",
                "ts",
                "html",
                "python",
                "ruby",
                "lua",
            },
            user_default_options = {
                RGB = true, -- #RGB hex codes
                RRGGBB = true, -- #RRGGBB hex codes
                names = true, -- "Name" codes like Blue or blue
                RRGGBBAA = true, -- #RRGGBBAA hex codes
                AARRGGBB = true, -- 0xAARRGGBB hex codes
                rgb_fn = true, -- CSS rgb() and rgba() functions
                hsl_fn = true, -- CSS hsl() and hsla() functions
                css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                -- Available modes for `mode`: foreground, background,  virtualtext
                mode = "background", -- Set the display mode.
                -- Available methods are false / true / "normal" / "lsp" / "both"
                -- True is same as normal
                tailwind = true, -- Enable tailwind colors
                -- parsers can contain values used in |user_default_options|
                sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
                virtualtext = "■",
                -- update color values even if buffer is not focused
                -- example use: cmp_menu, cmp_docs
                always_update = false,
            },
            -- all the sub-options of filetypes apply to buftypes
            buftypes = {},
        },
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            prompt = { prefix = { { "&", "FlashPromptIcon" } } },
        },
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "gs",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },

    {
        "https://github.com/LunarVim/bigfile.nvim",
        opts = {
            filesize = 2,
            features = {
                "indent_blankline",
                "illuminate",
                "lsp",
                "treesitter",
                "syntax",
                "matchparen",
                "vimopts",
                "filetype",
            },
        },
    },
})
--}}}

--{{{2 Colorscheme
table.insert(plugins, {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    name = "gruvbox",
    init = function()
        vim.o.background = "dark"
        vim.cmd.colorscheme("gruvbox")
    end,
    config = function()
        local gruvbox = require("gruvbox")
        local colors = gruvbox.palette
        gruvbox.setup({
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            -- invert background for search, diffs, statuslines and errors
            inverse = true,
            contrast = "", -- "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {
                -- Remove bright gray background from folding.
                -- Make the folding text color more vibrant.
                Folded = { fg = colors.bright_green, bg = colors.dark0 },
                FoldColumn = { bg = colors.dark0 },
                SignColumn = { bg = colors.dark0 },
            },
            dim_inactive = false,
            transparent_mode = false,
        })
    end,
})
--}}}

--{{{2 TUI

table.insert(plugins, {
    {
        "stevearc/dressing.nvim",
        opts = {},
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    {
        "akinsho/bufferline.nvim",
        version = "*",
        after = "catppuccin",
        event = "UiEnter",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = {
            options = {
                themable = true,
                -- separator_style = "slack",
                highlights = function()
                    require("catppuccin.groups.integrations.bufferline").get()
                end,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        separator = true,
                    },
                },
                hover = {
                    enabled = true,
                    delay = 200,
                    reveal = { "close" },
                },
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
        },
    },
})

--}}}

--{{{2 Parser
table.insert(plugins, {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                -- vim --
                "vim",
                "vimdoc",
                "query",
                "regex",
                -- lua --
                "lua",
                "luadoc",
                "luap",
                -- shell --
                "bash",
                -- notes --
                "markdown",
                "markdown_inline",
                "latex", -- requires tree-sitter-cli installed
                -- web --
                "html",
                "css",
                "javascript",
                "typescript",
                "tsx",
                -- other --
                "c",
                "cpp",
                "rust",
                "go",
                "python",
                -- config --
                "toml",
                "yaml",
                "ini",
                "json",
            },
            auto_install = true,
            ignore_install = {},
            indent = {
                enable = true,
                disable = { "html" },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    -- set to `false` to disable one of the mappings
                    init_selection = "gnn",
                    node_incremental = "grn",
                    scope_incremental = "grc",
                    node_decremental = "grm",
                },
            },
            highlight = {
                enable = true,
                disable = function(_, buf)
                    local max_filesize = 2000 * 1024 -- 100 KB
                    local ok, stats =
                        pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                -- additional_vim_regex_highlighting = false,
            },
        },
        config = function(_, opts)
            local treesitter_configs = require("nvim-treesitter.configs")
            treesitter_configs.setup(opts)
        end,
    },
})
--}}}

--{{{2 File explorer
table.insert(plugins, {
    {
        "stevearc/oil.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<leader>fe",
                function()
                    require("oil").open_float()
                end,
                desc = "Open oil.nvim",
            },
            {
                "<leader>fE",
                function()
                    vim.cmd("vsplit | wincmd r | vertical resize -29")
                    require("oil").open()
                end,
                desc = "Open oil.nvim",
            },
        },
        opts = {
            skip_confirm_for_simple_edits = true,
            use_default_keymaps = false,
            keymaps = {
                ["<CR>"] = "actions.select",
                ["g?"] = "actions.show_help",
                ["-"] = "actions.parent",
                ["_"] = "actions.open_cwd",
                -- ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["g."] = "actions.toggle_hidden",
                ["g\\"] = "actions.toggle_trash",
            },
            view_options = {
                show_hidden = true,
                case_insensitive = true,
            },
            float = {
                border = vim.g.FloatBorders,
                padding = 5,
                max_width = 50,
            },
            ssh = { border = vim.g.FloatBorders },
        },
    },
})
--}}}

--{{{2 Fuzzy Finder
table.insert(plugins, {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-symbols.nvim",
    },
    keys = function()
        local telescope = require("telescope.builtin")
        return {
            {
                "<leader>ff",
                telescope.find_files,
                desc = "Fuzzy find files in the current working directory.",
            },
            {
                "<leader>f?",
                telescope.keymaps,
                desc = "Show keymaps through fzf interface.",
            },
            {
                "<leader>fs",
                telescope.symbols,
                desc = "Show symbols through fzf interface.",
            },
            {
                "<leader>fw",
                telescope.live_grep,
                desc = "Live grep a string in the cwd through fzf interface.",
            },
            {
                "<leader>fc",
                telescope.colorscheme,
                desc = "Live grep a string in the cwd through fzf interface.",
            },
            {
                "<leader>fn",
                "<cmd>Telescope notify<cr><esc>",
                desc = "Show notifications list through fzf interface.",
            },
        }
    end,
    config = function()
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")
        local actions = require("telescope.actions")

        -- Clone the default Telescope configuration
        local vimgrep_arguments =
            { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- Show hidden/dot files
        table.insert(vimgrep_arguments, "--hidden")

        -- Hide files in the `.git` directory
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        local user_default_mappings = {
            ["i"] = {
                ["C-k"] = actions.move_selection_previous,
                ["C-j"] = actions.move_selection_next,
            },
        }

        telescope.setup({
            defaults = {
                mappings = user_default_mappings,
                vimgrep_arguments = vimgrep_arguments,
                pickers = {
                    find_files = {
                        find_command = {
                            "rg",
                            "--files",
                            "--hidden",
                            "--glob",
                            "!**/.git/*",
                        },
                    },
                },
            },
            extensions = {
                file_browser = {
                    mappings = user_default_mappings,
                },
            },
        })
    end,
})
--}}}

--{{{2 Org
table.insert(plugins, {
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            { "nvim-treesitter/nvim-treesitter" },
            { "nvim-tree/nvim-web-devicons" },
        },
        ft = { "markdown", "telekasten" },
        after = { "telekasten.nvim" },
        opts = {
            heading = {
                sign = false,
                position = "inline",
                width = "block",
                left_pad = 2,
                right_pad = 3,
            },
            anti_conceal = { enabled = true },
            dash = { width = 79 },
            latex = { enabled = false },
        },
    },

    {
        "3rd/image.nvim",
        ft = { "markdown", "telekasten", "norg" },
        opts = {},
    },

    {
        "nvim-orgmode/orgmode",
        config = function()
            local orgmode = require("orgmode")
            local org_root = "~/Notes/"
            local org_personal = org_root .. "personal/"
            local org_agenda = org_personal .. "agenda/"
            ---@diagnostic disable-next-line: missing-fields
            orgmode.setup({
                org_id_method = "ts",
                org_agenda_span = "week",
                org_log_repeat = "time",
                org_agenda_files = org_agenda,
                org_default_notes_file = org_root .. "refile.org",
                org_startup_indented = false,
                org_adapt_indentation = false,
            })
        end,
    },
})
--}}}

--{{{2 Autocompletion
table.insert(plugins, {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "windwp/nvim-autopairs" },
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            dependencies = {
                { "rafamadriz/friendly-snippets" },
                { "saadparwaiz1/cmp_luasnip" },
            },
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()

        --{{{3 nvim-autopairs
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        require("nvim-autopairs").setup()
        --3}}}

        --{{{3 User Interface: Window and Formatting
        local icons = {
            Text = "  ",
            Method = "  ",
            Function = "  ",
            Constructor = "  ",
            Field = "  ",
            Variable = "  ",
            Class = "  ",
            Interface = "  ",
            Module = "  ",
            Property = "  ",
            Unit = "  ",
            Value = "  ",
            Enum = "  ",
            Keyword = "  ",
            Snippet = "  ",
            Color = "  ",
            File = "  ",
            Reference = "  ",
            Folder = "  ",
            EnumMember = "  ",
            Constant = "  ",
            Struct = "  ",
            Event = "  ",
            Operator = "  ",
            TypeParameter = "  ",
        }

        local Window = {
            completion = {
                scrollbar = false,
                border = vim.g.FloatBorders,
                winhighlight = "Normal:CmpBorder,FloatBorder:None,Search:None",
            },
            documentation = {
                scrollbar = false,
                border = vim.g.FloatBorders,
                winhighlight = "Normal:CmpBorder,FloatBorder:None,Search:None",
            },
        }

        local Formatting = {
            expandable_indicator = false,
            fields = { "abbr", "kind", "menu" },
            format = function(_, item)
                item.kind = (icons[item.kind] or "") .. "[" .. item.kind .. "]"
                return item
            end,
        }
        --3}}}

        local Snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        }

        local Completion = { completeopt = "menu,menuone,noinsert,noselect" }

        local Sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            {
                name = "buffer",
                option = {
                    get_bufnrs = function()
                        return vim.api.nvim_list_bufs()
                    end,
                },
            },
        })

        local function Enabled()
            -- Disable `cmp` when the cursor is in a comment, unless in command mode.
            local context = require("cmp.config.context")
            local in_command_mode = vim.api.nvim_get_mode().mode == "c"
            local in_comment = context.in_treesitter_capture("comment")
                or context.in_syntax_group("Comment")
            if in_comment and not in_command_mode then
                return false
            end
            -- Disable `cmp` in prompt boxes, like telescope.
            -- src.: https://github.com/hrsh7th/nvim-cmp/issues/60
            local buftype = vim.api.nvim_buf_get_option(0, "buftype")
            if buftype == "prompt" then
                return false
            end
            -- In all other cases, enable `cmp`.
            return true
        end

        --{{{3 Mapping
        local luasnip = require("luasnip")

        local function has_words_before()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0
                and vim.api
                        .nvim_buf_get_lines(0, line - 1, line, true)[1]
                        :sub(col, col)
                        :match("%s")
                    == nil
        end

        local Mapping = {
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ select = false })
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                elseif has_words_before() then
                    cmp.complete()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<C-d>"] = cmp.mapping.scroll_docs(1),
            ["<C-u>"] = cmp.mapping.scroll_docs(-1),
            ["<C-.>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<Cr>"] = cmp.mapping({
                i = function(fallback)
                    if cmp.visible() and cmp.get_active_entry() then
                        cmp.confirm({
                            behavior = cmp.ConfirmBehavior.Replace,
                            select = false,
                        })
                    else
                        fallback()
                    end
                end,
                s = cmp.mapping.confirm({ select = false }),
                c = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = false,
                }),
            }),
        }
        --3}}}

        cmp.setup({
            window = Window,
            formatting = Formatting,
            completion = Completion,
            snippet = Snippet,
            mapping = Mapping,
            sources = Sources,
            sorting = defaults.sorting,
            enabled = Enabled,
        })

        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, {
                {
                    name = "cmdline",
                    option = { ignore_cmds = { "Man", "!" } },
                },
            }),
        })
    end,
})
--}}}

--{{{2 LSP
table.insert(plugins, {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "williamboman/mason.nvim",
                cmd = "Mason",
                keys = {
                    {
                        "<leader>lm",
                        "<cmd>Mason<cr>",
                        desc = "Open Mason's menu.",
                    },
                },
                opts = {},
            },
            {
                "williamboman/mason-lspconfig.nvim",
                event = { "BufReadPre", "BufNewFile" },
                opts = function()
                    local items = tools.lspconfig.items
                    return {
                        ensure_installed = items,
                    }
                end,
            },
            {
                "folke/neodev.nvim",
                ft = "lua",
                opts = {},
            },
        },
        config = function()
            -- Server Setup
            require("mason-lspconfig").setup({
                automatic_installation = false,
                ensure_installed = tools.lspconfig.items,
                handlers = tools.lspconfig.handlers,
            })

            -- Keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP keymaps/actions.",
                callback = function(event)
                    local opts = { buffer = event.buf }
                    local map = vim.keymap.set
                    map(
                        "n",
                        "<leader>lr",
                        "<cmd>lua vim.lsp.buf.rename()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "<leader>la",
                        "<cmd>lua vim.lsp.buf.code_action()<cr>",
                        opts
                    )
                    map({ "n", "x" }, "<leader>lf", function()
                        vim.lsp.buf.format({ async = false })
                    end, opts)
                    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    map(
                        "n",
                        "gd",
                        "<cmd>lua vim.lsp.buf.definition()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "gD",
                        "<cmd>lua vim.lsp.buf.declaration()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "gi",
                        "<cmd>lua vim.lsp.buf.implementation()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "go",
                        "<cmd>lua vim.lsp.buf.type_definition()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "gr",
                        "<cmd>lua vim.lsp.buf.references()<cr>",
                        opts
                    )
                    -- map(
                    --     "n",
                    --     "gs",
                    --     "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                    --     opts
                    -- )
                    map(
                        "n",
                        "gl",
                        "<cmd>lua vim.diagnostic.open_float()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "[d",
                        "<cmd>lua vim.diagnostic.goto_prev()<cr>",
                        opts
                    )
                    map(
                        "n",
                        "]d",
                        "<cmd>lua vim.diagnostic.goto_next()<cr>",
                        opts
                    )
                end,
            })
        end,
    },
})
--}}}

--{{{2 None LS
table.insert(plugins, {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "neovim/nvim-lspconfig",
            {
                "jay-babu/mason-null-ls.nvim",
                event = { "BufReadPre", "BufNewFile" },
            },
        },
        config = function()
            require("mason-null-ls").setup({
                automatic_installation = false,
                ensure_installed = tools.null_ls.items,
                handlers = tools.null_ls.handlers,
            })

            local null_ls = require("null-ls")
            null_ls.setup()
        end,
    },
})
--}}}

--{{{2 DAP
table.insert(plugins, {
    {
        "rcarriga/nvim-dap-ui",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            local mason_nvim_dap = require("mason-nvim-dap")
            mason_nvim_dap.setup({
                ensure_installed = tools.nvim_dap.items,
                automatic_installation = false,
                handlers = {},
            })
        end,
    },
})
--}}}

--{{{2 Code running
table.insert(plugins, {
    {
        "stevearc/overseer.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                -- direction = "bottom",
                -- min_height = 25,
                -- max_height = 25,
                default_detail = 1,
                bindings = {
                    ["q"] = "Close",
                },
            },
            form = { border = vim.g.FloatBorders },
            confirm = { border = vim.g.FloatBorders },
            task_win = { border = vim.g.FloatBorders },
            help_win = { border = vim.g.FloatBorders },
        },
    },

    {
        "Zeioth/compiler.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        dependencies = {
            "stevearc/overseer.nvim",
            "nvim-telescope/telescope.nvim",
        },
        opts = {},
        keys = {
            {
                "<leader>ro",
                "<cmd>CompilerOpen<cr>",
                desc = "Open Compiler.nvim telescope prompt.",
            },
            {
                "<leader>rr",
                "<cmd>CompilerRedo<cr>",
                desc = "Redo last Compiler.nvim task.",
            },
            {
                "<leader>rt",
                "<cmd>CompilerToggleResults<cr>",
                desc = "Toggle Compiler.nvim results.",
            },
        },
    },
})
--}}}

--{{{2 Git
table.insert(plugins, {
    {
        "lewis6991/gitsigns.nvim",
        opts = {},
    },

    {
        "tpope/vim-fugitive",
    },
})
--}}}

--{{{2 Integrations
table.insert(plugins, {
    {
        "alker0/chezmoi.vim",
        init = function()
            vim.g["chezmoi#use_tmp_buffer"] = true
        end,
    },

    {
        "mrjones2014/smart-splits.nvim",
        opts = {},
        config = function(_, opts)
            -- Resize splits
            vim.keymap.set("n", "<CS-h>", require("smart-splits").resize_left)
            vim.keymap.set("n", "<CS-j>", require("smart-splits").resize_down)
            vim.keymap.set("n", "<CS-k>", require("smart-splits").resize_up)
            vim.keymap.set("n", "<CS-l>", require("smart-splits").resize_right)
            -- Move cursor between splits
            vim.keymap.set(
                "n",
                "<C-h>",
                require("smart-splits").move_cursor_left
            )
            vim.keymap.set(
                "n",
                "<C-j>",
                require("smart-splits").move_cursor_down
            )
            vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
            vim.keymap.set(
                "n",
                "<C-l>",
                require("smart-splits").move_cursor_right
            )
            -- Move buffer between splits
            vim.keymap.set(
                "n",
                "<leader><leader>h",
                require("smart-splits").swap_buf_left
            )
            vim.keymap.set(
                "n",
                "<leader><leader>j",
                require("smart-splits").swap_buf_down
            )
            vim.keymap.set(
                "n",
                "<leader><leader>k",
                require("smart-splits").swap_buf_up
            )
            vim.keymap.set(
                "n",
                "<leader><leader>l",
                require("smart-splits").swap_buf_right
            )
            require("smart-splits").setup(opts)
        end,
    },
})
--}}}

-- Initialize plugins with plugin manager
require("lazy").setup(plugins, lazy_opts)

-- Keybind to access plugin manager's tui
vim.keymap.set({ "n", "v", "s", "x" }, "<leader>ll", "<cmd>Lazy<cr>")

--1}}}

--{{{1 Keybinds
local map = vim.keymap.set

-- QoL
map(
    { "n", "i", "v", "s" },
    "<C-s>",
    "<cmd>w<cr>",
    { desc = "Write buffer changes." }
)
map({ "n", "v", "s" }, "<leader>q", "ZQ", { desc = "Quit without writing." })
-- TODO: custom function to call ZQ multiple times if needed.
-- map({ "n", "v", "s" }, "<leader>q", function()
--     -- Call ZQ and if the current buffer changes to oil.nvim, call ZQ again.
-- end, { desc = "Quit without writing." })
map(
    { "i", "n" },
    "<esc>",
    "<cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch." }
)
map(
    { "i", "v", "c", "x", "n" },
    "<C-g>",
    "<esc>",
    { desc = "Exit insert mode with one hand." }
)
map(
    { "i", "n" },
    "<C-g>",
    "<cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch." }
)

-- Move LoC
map("v", "<S-k>", "<cmd>m+1<cr>vv")
map("v", "<S-j>", "<cmd>m-2<cr>vv")
map("x", "<S-k>", ":m '<-2<cr>gv=gv")
map("x", "<S-j>", ":m '>+1<cr>gv=gv")

-- Better Indent
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Movement
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Buffers
map({ "n", "v", "s" }, "<Tab>", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, "<S-Tab>", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, "[b", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, "]b", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, ";l", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, ";h", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer." })
map(
    { "n", "v", "s" },
    "<leader>bD",
    "<cmd>bd!<cr>",
    { desc = "Force close buffer." }
)

-- Folding
map(
    { "n", "v", "s", "x" },
    "<leader>a",
    "za",
    { desc = "Toggle folding status." }
)

-- Windows
map(
    { "n", "v", "s" },
    "|",
    "<cmd>vertical split<cr>",
    { desc = "Vertical window split." }
)
map(
    { "n", "v", "s" },
    "\\",
    "<cmd>horizontal split<cr>",
    { desc = "Horizontal window split." }
)

--1}}}

--{{{1 Commands
local autoft = {
    slint = function()
        vim.bo.filetype = "slint"
    end,
}

for ft, cb in pairs(autoft) do
    vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup(ft, { clear = true }),
        pattern = "*." .. ft,
        callback = cb,
    })
end

-- Detect *.slint files
-- vim.api.nvim_create_autocmd("BufEnter", {
--     group = vim.api.nvim_create_augroup("Slint", { clear = true }),
--     pattern = "*.slint",
--     callback = function()
--         vim.bo.filetype = "slint"
--     end,
-- })
--1}}}

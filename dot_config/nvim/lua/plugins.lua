-- mrcapivaro's neovim plugins config

-- Plugin Manager Bootstrap {{{1

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

local plugins = {}

-- 1}}}

-- Quality of Life {{{1

table.insert(plugins, {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                "gs",
                mode = { "n", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "gs",
                mode = { "o" },
                function()
                    require("flash").remote()
                end,
                desc = "Flash Treesitter",
            },
        },
        opts = {
            modes = {
                search = { enabled = false },
                char = { enabled = false },
            },
            prompt = {
                enabled = true,
                prefix = { { "&", "FlashPromptIcon" } },
            },
        },
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            delay = function(ctx)
                return ctx.plugin and 500 or 500
            end,
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },

    {
        "mg979/vim-visual-multi",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        opts = {
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                comment_visual = "gc",
                textobject = "",
            },
        },
    },

    {
        "mrjones2014/smart-splits.nvim",
        opts = {},
        config = function(_, opts)
            -- Resize splits
            vim.keymap.set("n", "<C-S-h>", require("smart-splits").resize_left)
            vim.keymap.set("n", "<C-S-j>", require("smart-splits").resize_down)
            vim.keymap.set("n", "<C-S-k>", require("smart-splits").resize_up)
            vim.keymap.set("n", "<C-S-l>", require("smart-splits").resize_right)
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

-- 1}}}
-- Text Editing {{{1

table.insert(plugins, {
    {
        "echasnovski/mini.splitjoin",
        version = false,
        opts = {
            -- Module mappings. Use `''` (empty string) to disable one.
            -- Created for both Normal and Visual modes.
            mappings = {
                toggle = "gS",
                split = "",
                join = "",
            },

            -- Detection options: where split/join should be done
            detect = {
                -- Array of Lua patterns to detect region with arguments.
                -- Default: { '%b()', '%b[]', '%b{}' }
                brackets = nil,

                -- String Lua pattern defining argument separator
                separator = ",",

                -- Array of Lua patterns for sub-regions to exclude separators from.
                -- Enables correct detection in presence of nested brackets and quotes.
                -- Default: { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
                exclude_regions = nil,
            },

            -- Split options
            split = {
                hooks_pre = {},
                hooks_post = {},
            },

            -- Join options
            join = {
                hooks_pre = {},
                hooks_post = {},
            },
        },
    },
})

-- 1}}}
-- Appearance {{{1

table.insert(plugins, {
    {
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
    },

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
        "echasnovski/mini.statusline",
        version = false,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
    },
})

-- 1}}}
-- Treesitter {{{1

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

-- 1}}}
-- File explorer {{{1

table.insert(plugins, {
    {
        "echasnovski/mini.files",
        version = "*",
        keys = {
            {
                "<leader>fe",
                function()
                    MiniFiles.open()
                end,
                { desc = "Open file explorer." },
            },
        },
        opts = {
            mappings = {
                reset = "gr",
                synchronize = "<leader>w",
                close = "q",
                go_in = "L",
                go_out = "H",
                go_in_plus = "",
                go_out_plus = "",
            },
        },
    },
})

-- 1}}}
-- Fuzzy Finder {{{1

table.insert(plugins, {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
        require("fzf-lua").setup(opts)
    end,
    keys = {
        {
            "<leader>ff",
            ":FzfLua files<cr>",
            desc = "Fuzzy find files in the current working directory.",
        },
        {
            "<leader>fw",
            ":FzfLua live_grep<cr>",
            desc = "Fuzzy find a grep output.",
        },
    },
})

-- 1}}}
-- Org {{{1

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
            exclude = {
                buftypes = { "nofile" },
            },
            heading = {
                sign = false,
                position = "inline",
                width = "block",
                left_pad = 2,
                right_pad = 3,
            },
            anti_conceal = { enabled = true },
            dash = { width = 80 },
            code = {
                enabled = true,
                disable_background = true,
                border = "none",
            },
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
        dependencies = {
            { "akinsho/org-bullets.nvim", opts = {} },
        },
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

-- 1}}}
-- LSP {{{1

local tools = require("tools")

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
                opts = { ensure_installed = tools.lspconfig.items },
            },
            {
                "folke/neodev.nvim",
                ft = "lua",
                opts = {},
            },
        },
        config = function()
            require("configs.lsp")
        end,
    },
})

-- 1}}}
-- None LS {{{1

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

-- 1}}}
-- TODO: Nvim DAP
-- Auto Complete {{{1

table.insert(plugins, {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "v0.*",
    opts = {
        enabled = function()
            return not vim.tbl_contains(
                    { "markdown", "org" },
                    vim.bo.filetype
                )
                and vim.bo.buftype ~= "prompt"
                and vim.b.completion ~= false
        end,

        completion = {
            menu = {
                border = "single",
                winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpDocCursorLine,Search:None",
            },
            list = {
                selection = "manual",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },

        keymap = {
            preset = "none",

            ["<C-.>"] = { "show", "show_documentation", "hide_documentation" },

            ["<C-h>"] = { "hide" },
            ["<C-k>"] = { "select_prev", "fallback" },
            ["<C-j>"] = { "select_next", "fallback" },
            ["<C-l>"] = { "select_and_accept", "fallback" },

            ["<C-u>"] = { "scroll_documentation_up", "fallback" },
            ["<C-d>"] = { "scroll_documentation_down", "fallback" },

            ["<Tab>"] = { "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
        },

        appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = "mono",
        },

        sources = {
            default = { "lsp", "path", "snippets", "buffer" },
            cmdline = function()
                local type = vim.fn.getcmdtype()
                -- Disable auto complete on search
                if type == "/" or type == "?" then
                    return {}
                end
                -- Commands
                if type == ":" then
                    return { "cmdline", "path" }
                end
                -- else
                return {}
            end,
        },

        signature = { enabled = true },
    },
})

-- 1}}}
-- Tasks {{{1

table.insert(plugins, {
    {
        "stevearc/overseer.nvim",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                -- direction = "bottom",
                -- max_height = 25,
                default_detail = 1,
                bindings = {
                    ["q"] = "Close",
                },
            },
            form = { border = "single" },
            confirm = { border = "single" },
            task_win = { border = "single" },
            help_win = { border = "single" },
        },
    },
})

-- 1}}}
-- Versioning {{{1

table.insert(plugins, {
    {
        "echasnovski/mini-git",
        version = "*",
        main = "mini.git",
        opts = {},
    },

    { "lewis6991/gitsigns.nvim", opts = {} },
})

-- 1}}}
-- Web Development {{{1

table.insert(plugins, {
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
            },
            user_default_options = {
                RGB = true,
                RRGGBB = true,
                names = true,
                RRGGBBAA = true,
                AARRGGBB = true,
                rgb_fn = true,
                hsl_fn = true,
                css = true,
                css_fn = true,
                mode = "background",
                tailwind = true,
                sass = { enable = true, parsers = { "css" } },
                virtualtext = "■",
                always_update = false,
            },
            buftypes = {},
        },
    },
})

-- 1}}}

-- Plugin Manager Setup {{{1

require("lazy").setup(plugins, {
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
})

-- Keymap to access the plugin manager's TUI
vim.keymap.set({ "n", "v", "s", "x" }, "<leader>pm", "<cmd>Lazy<cr>")

-- 1}}}

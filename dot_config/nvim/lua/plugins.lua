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
                "s",
                mode = { "n", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "s",
                mode = { "o" },
                function()
                    require("flash").remote()
                end,
                desc = "Flash Treesitter",
            },
        },
        opts = {
            labels = "asdfghjklqwertyuiopzxcvbnm",
            search = {
                multi_window = true,
                -- search direction
                forward = true,
                -- when `false`, find only matches in the given direction
                wrap = true,
                mode = "exact",
                -- behave like `incsearch`
                incremental = false,
                exclude = {
                    "notify",
                    "cmp_menu",
                    "noice",
                    "flash_prompt",
                    function(win)
                        -- exclude non-focusable windows
                        return not vim.api.nvim_win_get_config(win).focusable
                    end,
                },
            },
            jump = {
                -- save location in the jumplist
                jumplist = true,
                -- jump position
                pos = "start", ---@type "start" | "end" | "range"
                -- add pattern to search history
                history = false,
                -- add pattern to search register
                register = false,
                -- clear highlight after jump
                nohlsearch = false,
                -- automatically jump when there is only one match
                autojump = true,
                -- You can force inclusive/exclusive jumps by setting the
                -- `inclusive` option. By default it will be automatically
                -- set based on the mode.
                inclusive = nil, ---@type boolean?
                -- jump position offset. Not used for range jumps.
                -- 0: default
                -- 1: when pos == "end" and pos < current position
                offset = nil, ---@type number
            },
            label = {
                -- allow uppercase labels
                uppercase = true,
                -- add any labels with the correct case here, that you want to exclude
                exclude = "",
                -- add a label for the first match in the current window.
                -- you can always jump to the first match with `<CR>`
                current = true,
                -- show the label after the match
                after = true, ---@type boolean|number[]
                -- show the label before the match
                before = false, ---@type boolean|number[]
                -- position of the label extmark
                style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
                -- flash tries to re-use labels that were already assigned to a position,
                -- when typing more characters. By default only lower-case labels are re-used.
                reuse = "lowercase", ---@type "lowercase" | "all" | "none"
                -- for the current window, label targets closer to the cursor first
                distance = true,
                -- minimum pattern length to show labels
                -- Ignored for custom labelers.
                min_pattern_length = 0,
                -- Enable this to use rainbow colors to highlight labels
                -- Can be useful for visualizing Treesitter ranges.
                rainbow = {
                    enabled = false,
                    -- number between 1 and 9
                    shade = 5,
                },
                -- With `format`, you can change how the label is rendered.
                -- Should return a list of `[text, highlight]` tuples.
                ---@class Flash.Format
                ---@field state Flash.State
                ---@field match Flash.Match
                ---@field hl_group string
                ---@field after boolean
                ---@type fun(opts:Flash.Format): string[][]
                format = function(opts)
                    return { { opts.match.label, opts.hl_group } }
                end,
            },
            highlight = {
                -- show a backdrop with hl FlashBackdrop
                backdrop = true,
                -- Highlight the search matches
                matches = true,
                -- extmark priority
                priority = 5000,
                groups = {
                    match = "FlashMatch",
                    current = "FlashCurrent",
                    backdrop = "FlashBackdrop",
                    label = "FlashLabel",
                },
            },
            -- action to perform when picking a label.
            -- defaults to the jumping logic depending on the mode.
            ---@type fun(match:Flash.Match, state:Flash.State)|nil
            action = nil,
            -- initial pattern to use when opening flash
            pattern = "",
            -- When `true`, flash will try to continue the last search
            continue = false,
            -- Set config to a function to dynamically change the config
            config = nil, ---@type fun(opts:Flash.Config)|nil
            -- You can override the default options for a specific mode.
            -- Use it with `require("flash").jump({mode = "forward"})`
            ---@type table<string, Flash.Config>
            modes = {
                -- options used when flash is activated through
                -- a regular search with `/` or `?`
                search = {
                    -- when `true`, flash will be activated during regular search by default.
                    -- You can always toggle when searching with `require("flash").toggle()`
                    enabled = false,
                    highlight = { backdrop = false },
                    jump = {
                        history = true,
                        register = true,
                        nohlsearch = true,
                    },
                    search = {
                        -- `forward` will be automatically set to the search direction
                        -- `mode` is always set to `search`
                        -- `incremental` is set to `true` when `incsearch` is enabled
                    },
                },
                -- options used when flash is activated through
                -- `f`, `F`, `t`, `T`, `;` and `,` motions
                char = {
                    enabled = false,
                    -- dynamic configuration for ftFT motions
                    config = function(opts)
                        -- autohide flash when in operator-pending mode
                        opts.autohide = opts.autohide
                            or (
                                vim.fn.mode(true):find("no")
                                and vim.v.operator == "y"
                            )

                        -- disable jump labels when not enabled, when using a count,
                        -- or when recording/executing registers
                        opts.jump_labels = opts.jump_labels
                            and vim.v.count == 0
                            and vim.fn.reg_executing() == ""
                            and vim.fn.reg_recording() == ""

                        -- Show jump labels only in operator-pending mode
                        -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
                    end,
                    -- hide after jump when not using jump labels
                    autohide = false,
                    -- show jump labels
                    jump_labels = false,
                    -- set to `false` to use the current line only
                    multi_line = true,
                    -- When using jump labels, don't use these keys
                    -- This allows using those keys directly after the motion
                    label = { exclude = "hjkliardc" },
                    -- by default all keymaps are enabled, but you can disable some of them,
                    -- by removing them from the list.
                    -- If you rather use another key, you can map them
                    -- to something else, e.g., { [";"] = "L", [","] = H }
                    keys = { "f", "F", "t", "T", ";", "," },
                    ---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
                    -- The direction for `prev` and `next` is determined by the motion.
                    -- `left` and `right` are always left and right.
                    char_actions = function(motion)
                        return {
                            [";"] = "next", -- set to `right` to always go right
                            [","] = "prev", -- set to `left` to always go left
                            -- clever-f style
                            [motion:lower()] = "next",
                            [motion:upper()] = "prev",
                            -- jump2d style: same case goes next, opposite case goes prev
                            -- [motion] = "next",
                            -- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
                        }
                    end,
                    search = { wrap = false },
                    highlight = { backdrop = true },
                    jump = {
                        register = false,
                        -- when using jump labels, set to 'true' to automatically jump
                        -- or execute a motion when there is only one match
                        autojump = false,
                    },
                },
                -- options used for treesitter selections
                -- `require("flash").treesitter()`
                treesitter = {
                    labels = "abcdefghijklmnopqrstuvwxyz",
                    jump = { pos = "range", autojump = true },
                    search = { incremental = false },
                    label = { before = true, after = true, style = "inline" },
                    highlight = {
                        backdrop = false,
                        matches = false,
                    },
                },
                treesitter_search = {
                    jump = { pos = "range" },
                    search = {
                        multi_window = true,
                        wrap = true,
                        incremental = false,
                    },
                    remote_op = { restore = true },
                    label = { before = true, after = true, style = "inline" },
                },
                -- options used for remote flash
                remote = {
                    remote_op = { restore = true, motion = true },
                },
            },
            -- options for the floating window that shows the prompt,
            -- for regular jumps
            -- `require("flash").prompt()` is always available to get the prompt text
            prompt = {
                enabled = true,
                prefix = { { "⚡", "FlashPromptIcon" } },
                win_config = {
                    relative = "editor",
                    width = 1, -- when <=1 it's a percentage of the editor width
                    height = 1,
                    row = -1, -- when negative it's an offset from the bottom
                    col = 0, -- when negative it's an offset from the right
                    zindex = 1000,
                },
            },
            -- options for remote operator pending mode
            remote_op = {
                -- restore window views and cursor position
                -- after doing a remote operation
                restore = false,
                -- For `jump.pos = "range"`, this setting is ignored.
                -- `true`: always enter a new motion when doing a remote operation
                -- `false`: use the window's cursor position and jump target
                -- `nil`: act as `true` for remote windows, `false` for the current window
                motion = false,
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
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = { ignore = "^$" },
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
                synchronize = "<C-s>",
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

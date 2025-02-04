local plugins = {}

-- Appearance {{{

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
                    strings = false,
                    emphasis = false,
                    comments = false,
                    operators = false,
                    folds = false,
                },
                strikethrough = false,
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
        "rebelot/heirline.nvim",
        dependencies = { "SmiteshP/nvim-navic" },
        config = function()
            require("custom.configs.heirline")
        end,
    },
})

-- }}}
-- Keymaps {{{

table.insert(plugins, {
    {
        "anuvyklack/hydra.nvim",
        dependencies = { { "jbyuki/venn.nvim" } },
        config = function()
            require("custom.configs.hydra")
        end,
    },

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            delay = function(ctx)
                return ctx.plugin and 500 or 500
            end,
        },
    },

    {
        "dynamotn/Navigator.nvim",
        keys = {
            {
                desc = "Move focus to left window.",
                "<C-h>",
                "<CMD>NavigatorLeft<CR>",
            },
            {
                desc = "Move focus to bottom window.",
                "<C-j>",
                "<CMD>NavigatorDown<CR>",
            },
            {
                desc = "Move focus to top window.",
                "<C-k>",
                "<CMD>NavigatorUp<CR>",
            },
            {
                desc = "Move focus to right window.",
                "<C-l>",
                "<CMD>NavigatorRight<CR>",
            },
        },
        opts = {},
    },
})

-- }}}
-- Marks {{{

table.insert(plugins, {
    {
        "chentoast/marks.nvim",
        opts = {},
    },
})

-- }}}
-- Motions {{{

table.insert(plugins, {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        keys = {
            {
                desc = "Character jump.",
                mode = { "n", "v" },
                "gs",
                function()
                    require("flash").jump()
                end,
            },
            {
                desc = "Remote character jump on operator pending mode.",
                mode = { "o" },
                "gs",
                function()
                    require("flash").remote()
                end,
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
})

-- }}}
-- Text Editing {{{

table.insert(plugins, {
    {
        "mg979/vim-visual-multi",
        event = { "BufReadPre", "BufNewFile" },
    },

    {
        "echasnovski/mini.comment",
        version = false,
        event = "VeryLazy",
        opts = {
            options = {
                custom_commentstring = function()
                    if
                        vim.bo.commentstring ~= ""
                        and vim.bo.commentstring ~= nil
                    then
                        return vim.bo.commentstring
                    end
                    return nil
                end,
            },
            mappings = {
                comment = "<space>c",
                comment_line = "<space>cc",
                comment_visual = "<space>c",
                textobject = "",
            },
        },
    },

    {
        "echasnovski/mini.splitjoin",
        version = false,
        opts = {
            -- Module mappings. Use `""` (empty string) to disable one.
            -- Created for both Normal and Visual modes.
            mappings = {
                toggle = "S",
                split = "",
                join = "",
            },

            -- Detection options: where split/join should be done
            detect = {
                -- Array of Lua patterns to detect region with arguments.
                -- Default: { "%b()", "%b[]", "%b{}" }
                brackets = nil,

                -- String Lua pattern defining argument separator
                separator = ",",

                -- Array of Lua patterns for sub-regions to exclude separators from.
                -- Enables correct detection in presence of nested brackets and quotes.
                -- Default: { "%b()", "%b[]", "%b{}", "%b""", "%b""" }
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

-- }}}
-- Treesitter {{{

table.insert(plugins, {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        build = ":TSUpdate",
        config = function()
            require("custom.configs.treesitter")
        end,
    },
})

-- }}}
-- File explorer {{{

table.insert(plugins, {
    {
        "stevearc/oil.nvim",
        keys = {
            {
                "<space>e",
                function()
                    require("oil").open_float()
                end,
                { desc = "Open file explorer." },
            },
        },
        config = function()
            local oil = require("oil")
            oil.setup({
                skip_confirm_for_simple_edits = true,
                keymaps_help = { border = "single" },
                confirmation = { border = "single" },
                progress = { border = "single" },
                ssh = { border = "single" },
                columns = {
                    "icon",
                    -- "permissions",
                    -- "size",
                    -- "mtime",
                },
                float = { border = "single" },
            })
        end,
    },
})

-- }}}
-- Fuzzy Finder {{{

table.insert(plugins, {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-telescope/telescope-symbols.nvim",
        },
        event = "VeryLazy",
        keys = {
            {
                desc = "Fuzzy Search files in cwd.",
                "<leader>ff",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.find_files({ hidden = true })
                end,
            },
            {
                desc = "Fuzzy Search for word in cwd with ripgrep/grep.",
                "<leader>fw",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.live_grep()
                end,
            },
            {
                desc = "Fuzzy Search help tags.",
                "<leader>fh",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.help_tags()
                end,
            },
            {
                desc = "Fuzzy Search marks.",
                "<leader>fm",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.marks()
                end,
            },
            {
                desc = "Fuzzy Search buffers.",
                "<leader>fb",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.buffers({ select_current = true })
                end,
            },
            {
                desc = "Fuzzy Search keymaps.",
                "<leader>fk",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.keymaps()
                end,
            },
            {
                desc = "Fuzzy Search vim options.",
                "<leader>fo",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.vim_options()
                end,
            },
            {
                desc = "Fuzzy Search vim\"<leader>f quicklist.",
                "<leader>fq",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.quickfix()
                end,
            },
            {
                desc = "Fuzzy Search symbols.",
                "<leader>fs",
                function()
                    local telescope_builtin = require("telescope.builtin")
                    telescope_builtin.symbols()
                end,
            },
        },
        config = function()
            require("custom.configs.telescope")
        end,
    },

    {
        "nvim-telescope/telescope-fzf-native.nvim",
        dependencies = "telescope.nvim",
        build = table.concat({
            "cmake",
            "-S.",
            "-Bbuild",
            "-DCMAKE_BUILD_TYPE=Release",
            "&&",
            "cmake",
            "--build build",
            "--config Release",
        }, " "),
        config = function()
            require("telescope").load_extension("fzf")
        end,
    },
})

-- }}}
-- Tasks {{{

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

-- }}}
-- Versioning {{{

table.insert(plugins, {
    {
        "echasnovski/mini-git",
        version = "*",
        main = "mini.git",
        opts = {},
    },

    { "lewis6991/gitsigns.nvim", opts = {} },
})

-- }}}
-- Org {{{

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
            -- exclude = {
            --     buftypes = { "nofile" },
            -- },
            heading = {
                sign = false,
                icons = { "◉ ", "○ ", "◆ ", "◇ ", "✸ ", "✿ " },
                position = "inline",
                backgrounds = {},
            },
            anti_conceal = { enabled = true },
            dash = { width = 80 },
            code = {
                disable_background = { "nofile", "diff" },
                width = "block",
                left_pad = 1,
                right_pad = 1,
                language_pad = 1,
                -- highlight = "GruvboxBg0",
            },
            latex = { enabled = false },
        },
    },

    {
        "3rd/image.nvim",
        ft = { "markdown", "telekasten", "norg", "org" },
        opts = {},
    },

    {
        "3rd/diagram.nvim",
        dependencies = { "3rd/image.nvim" },
        opts = {
            -- renderer_options = {
            --     d2 = {
            --         theme_id = nil,
            --         dark_theme_id = nil,
            --         scale = nil,
            --         layout = nil,
            --         sketch = true,
            --     },
            -- }
        },
    },

    {
        "nvim-orgmode/orgmode",
        dependencies = {
            {
                "akinsho/org-bullets.nvim",
                opts = {
                    symbols = {
                        headlines = {
                            "◉ ",
                            "○ ",
                            "◆ ",
                            "◇ ",
                            "✸ ",
                            "✿ "
                        },
                    },
                },
            },
        },
        config = function()
            local orgmode = require("orgmode")
            local org_root = "~/Notes/"
            local org_personal = org_root .. "personal/"
            local org_agenda = org_personal .. "agenda/"
            ---@diagnostic disable-next-line: missing-fields
            orgmode.setup({
                org_startup_folded = "content",
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

-- }}}

-- LSP {{{

table.insert(plugins, {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        opts = {},
    },

    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "SmiteshP/nvim-navic", opts = {} },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            require("custom.configs.lsp")
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim", "nvim-lspconfig" },
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            local tools = require("custom.configs.tools")
            mason_lspconfig.setup({
                ensure_installed = tools.lspconfig.items,
            })
        end,
    },
})

-- }}}
-- None LS {{{

table.insert(plugins, {
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-lspconfig",
            "jay-babu/mason-null-ls.nvim",
        },
        config = function()
            local tools = require("custom.configs.tools")
            require("mason-null-ls").setup({
                automatic_installation = false,
                ensure_installed = tools.null_ls.items,
                handlers = tools.null_ls.handlers,
            })
            require("null-ls").setup()
        end,
    },
})

-- }}}
-- Auto Complete {{{

table.insert(plugins, {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
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
                selection = { preselect = false, auto_insert = true },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },
        },

        keymap = {
            preset = "none",

            ["<C-.>"] = { "show", "show_documentation", "hide_documentation" },

            ["<C-e>"] = { "hide", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },
            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-m>"] = { "accept", "fallback" },

            ["<Left>"] = { "hide", "fallback" },
            ["<Up>"] = { "select_prev", "fallback" },
            ["<Down>"] = { "select_next", "fallback" },
            ["<Right>"] = { "accept", "fallback" },

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
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    score_offset = 100,
                },
            },
            cmdline = function()
                local cmdtype = vim.fn.getcmdtype()
                if cmdtype == ":" then
                    return { "cmdline", "path" }
                end
                return {}
            end,
        },

        signature = { enabled = true },
    },
})

-- }}}

-- Web Development {{{

table.insert(plugins, {
    {
        "barrett-ruth/live-server.nvim",
        cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
        keys = {
            {
                ",s",
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

-- }}}
-- Performance {{{

table.insert(plugins, {
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

-- }}}

return plugins

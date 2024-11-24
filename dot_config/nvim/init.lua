-- ~/.config/nvim/init.lua

--{{{Options
---User Interace
vim.g.FloatBorders = "single" -- { "┌", "─", "┐", "│", "┘", "─", "└", "│" }

---Keymap Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

---Listchars
-- vim.api.nvim_set_hl(0, "Whitespace", { fg = "#313244" })
-- vim.opt.listchars = { space = "·", tab = "> " }
-- vim.opt.listchars = { space = "·", tab = "> ", eol = "␤" }

---Vim Options
local vim_opt = {
    clipboard = "unnamedplus",
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
    expandtab = true,
    smartindent = true,
    termguicolors = true,
    number = true,
    relativenumber = true,
    signcolumn = "yes",
    wrap = false,
    list = true,
    completeopt = "menu,menuone,noselect",
    showmode = true,
    cmdheight = 1,
    colorcolumn = "80",
    hlsearch = true,
    incsearch = true,
    autowrite = true,
    swapfile = false,
    backup = false,
    ignorecase = true,
    spelllang = { "en_US.UTF-8" },
    scrolloff = 16,
    sidescrolloff = 8,
    updatetime = 50,
    virtualedit = "block",
    conceallevel = 2,
    cursorline = true,
    -- folding
    foldmethod = "marker", -- The default marker is {{{,}}}
    foldlevel = 0, -- 0 means that folds are closed by default. 99 inverses it.
}

for k, v in pairs(vim_opt) do
    vim.opt[k] = v
end

-- Conceal is normal and command mode, but not on the cursorline.
vim.opt.concealcursor:remove("n")

-- Generalized Keybinds
-- local keybinds = {
--     mod = "C", -- Control
--     leader = " ", -- Space
--     localleader = ",", -- Comma
--     movement = {
--         left = "h",
--         down = "j",
--         up = "k",
--         right = "l",
--     },
--     completion = {
--         down = { "C-j", "Tab" },
--         up = { "C-k", "S-Tab" },
--         accept = { "C-l", "Return" },
--         close = { "C-h", "C-g" },
--         open = { "C-." },
--     },
-- }
--}}}

--{{{Tools
local tools = {}

tools.lspconfig = {
    items = {
        "lua_ls",
        "html",
        "cssls",
        "emmet_ls",
        "clangd",
        "pyright",
        "ruff_lsp",
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
--}}}

--{{{Plugins
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

--{{{2 Template
table.insert(plugins, {
    -- code
})
--}}}

--{{{2 Colorscheme
table.insert(plugins, {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    init = function()
        vim.g.dark_theme = "catppuccin-mocha"
        vim.g.light_theme = "catppuccin-latte"
        vim.g.current_theme = vim.g.dark_theme
        vim.cmd.colorscheme(vim.g.current_theme)
    end,
    keys = {
        {
            "<leader>tt",
            function()
                local toggle_theme = vim.g.current_theme == vim.g.dark_theme
                        and vim.g.light_theme
                    or vim.g.dark_theme
                print(vim.toggle_theme)
                vim.g.current_theme = toggle_theme
                vim.cmd.colorscheme(vim.g.current_theme)
            end,
            desc = "Toggle theme dark/light",
        },
    },
    opts = {
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
            light = "latte",
            dark = "mocha",
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
            enabled = false, -- dims the background color of inactive window
            shade = "dark",
            percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = true, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = {},
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            aerial = true,
            overseer = true,
            neotree = true,
            noice = true,
            mason = true,
            markdown = true,
            navic = { enabled = true },
            telescope = {
                enabled = true,
                -- style = "nvchad",
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
        lazy = false,
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").open_float()
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
                ["gs"] = "actions.change_sort",
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
    {
        "mikavilpas/yazi.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<leader>E",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            -- {
            --     "<leader>cw",
            --     "<cmd>Yazi cwd<cr>",
            --     desc = "Open the file manager in nvim's working directory",
            -- },
            {
                -- NOTE: this requires a version of yazi that includes
                -- https://github.com/sxyazi/yazi/pull/1305 from 2024-07-18
                "<C-Up>",
                "<cmd>Yazi toggle<cr>",
                desc = "Resume the last yazi session",
            },
        },
        opts = {
            open_for_directories = true,
            keymaps = {
                show_help = "<F1>",
            },
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
        "nvim-neorg/neorg",
        version = "*",
        ft = { "markdown", "telekasten", "norg" },
        opts = {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {},
                ["core.integrations.image"] = {},
                ["core.latex.renderer"] = {},
            },
        },
    },

    {
        "nvim-telekasten/telekasten.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        ft = { "markdown", "telekasten", "norg" },
        keys = {
            {
                "<localleader><leader>",
                "<cmd>Telekasten toggle_todo<cr>",
                desc = "telekasten.nvim: toggle todo.",
            },
            {
                "<localleader>ff",
                "<cmd>Telekasten find_notes<cr>",
                desc = "telekasten.nvim: find note by name.",
            },
            {
                "<localleader>ft",
                "<cmd>Telekasten show_tags<cr>",
                desc = "telekasten.nvim: find note by tag.",
            },
            {
                "<localleader>fl",
                "<cmd>Telekasten find_friends<cr>",
                desc = "telekasten.nvim: find notes linked to link under cursor.",
            },
            {
                "<localleader>n",
                "<cmd>Telekasten new_templated_note<cr>",
                desc = "telekasten.nvim: new note from chosen template.",
            },
            {
                "<localleader>N",
                "<cmd>Telekasten new_note<cr>",
                desc = "telekasten.nvim: new note.",
            },
            {
                "<localleader>c",
                "<cmd>Telekasten show_calendar<cr>",
                desc = "telekasten.nvim: show the calendar.",
            },
        },
        config = function()
            local telekasten = require("telekasten")
            local notes_dir = vim.fn.expand("~/Documents/Sync/")
            local templates_dir = notes_dir .. "900-assets/940-nvim-templates/"
            local journal_dir = notes_dir .. "200-personal/210-journal/"
            telekasten.setup({
                tag_notation = "yaml-bare",
                uuid_type = "%d%m%Y%H%M",
                filename_space_subst = "-",
                filename_small_case = true,
                image_link_style = "wiki",
                install_syntax = true,
                home = notes_dir,
                dailies = journal_dir,
                weeklies = journal_dir,
                templates = templates_dir,
                template_new_note = templates_dir .. "note.md",
                template_new_daily = templates_dir .. "daily.md",
                template_new_weekly = templates_dir .. "weekly.md",
            })
        end,
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

        --{{{nvim-autopairs
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        require("nvim-autopairs").setup()
        --}}}

        --{{{User Interface: Window and Formatting
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
                border = "single",
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
        --}}}

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

        --{{{Mapping
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
        --}}}

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
            sources = cmp.config.sources(
                { { name = "path" } },
                {
                    {
                        name = "cmdline",
                        option = { ignore_cmds = { "Man", "!" } },
                    },
                }
            ),
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
                    map(
                        "n",
                        "gs",
                        "<cmd>lua vim.lsp.buf.signature_help()<cr>",
                        opts
                    )
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
            form = { border = "single" },
            confirm = { border = "single" },
            task_win = { border = "single" },
            help_win = { border = "single" },
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
        lazy = false,
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
        lazy = false,
        init = function()
            vim.g["chezmoi#use_tmp_buffer"] = true
        end,
    },

    {
        "mrjones2014/smart-splits.nvim",
        opts = {},
        lazy = false,
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

--{{{2 User Interface
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
        "nvimdev/indentmini.nvim",
        opts = {
            char = "┊",
            exclude = {
                "markdown",
            },
            minlevel = 2,
        },
        config = function(_, opts)
            vim.cmd.highlight("IndentLine guifg=#313244")
            vim.cmd.highlight("IndentLineCurrent guifg=#585b70")
            require("indentmini").setup(opts)
        end,
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
        lazy = false,
        name = "colorizer",
        opts = {
            filetypes = {
                "css",
                "js",
                "ts",
                "html",
                "python",
                "c",
                "cpp",
                "ruby",
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
        "ggandor/leap.nvim",
        lazy = false,
        config = function()
            local map = vim.keymap.set
            map("n", ";", "<Plug>(leap)")
            map({ "x", "o" }, ";", "<Plug>(leap-forward)")
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
--}}}

-- Setup plugin manager and it's plugins
require("lazy").setup(plugins, lazy_opts)
-- Keybind to access plugin manager's tui
vim.keymap.set({ "n", "v", "s", "x" }, "<leader>ll", "<cmd>Lazy<cr>")
--}}}

--{{{Keybinds
local map = vim.keymap.set

-- QoL
map(
    { "n", "i", "v", "s" },
    "<C-s>",
    "<cmd>w<cr>",
    { desc = "Write buffer changes." }
)
map({ "n", "v", "s" }, "<leader>q", "ZQ", { desc = "Quit without writing." })
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
map({ "n", "v", "s" }, "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer." })
map(
    { "n", "v", "s" },
    "<leader>bD",
    "<cmd>bd!<cr>",
    { desc = "Force close buffer." }
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

-- Other
map({ "n", "v", "s" }, "<C-P>", ":")
--}}}

--{{{Commands
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
--}}}

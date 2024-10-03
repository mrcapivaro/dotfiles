return {
    {
        "stevearc/dressing.nvim",
        opts = {},
    },

    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",
                opts = {
                    on_open = function(win)
                        if vim.api.nvim_win_is_valid(win) then
                            vim.api.nvim_win_set_config(
                                win,
                                { border = vim.g.FloatBorders }
                            )
                        end
                    end,
                    render = "wrapped-compact",
                    stages = "static",
                    timeout = 2 * 1000,
                    top_down = false,
                },
            },
        },
        opts = {
            presets = {
                lsp_doc_border = true,
                long_message_to_split = true,
            },
            views = {
                cmdline_popup = {
                    border = {
                        style = "none",
                        padding = { 1, 1 },
                    },
                    win_options = {
                        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
                    },
                },
                hover = {
                    border = { style = vim.g.FloatBorders },
                    size = { max_width = 80 },
                },
            },
        },
    },

    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },

    -- {
    --     "nvimdev/indentmini.nvim",
    --     event = "BufEnter",
    --     opts = {
    --         minlevel = 2,
    --         char = "│",
    --         exclude = {
    --             "markdown",
    --             "erlang",
    --         },
    --     },
    --     config = function(_, opts)
    --         require("indentmini").setup(opts)
    --         vim.cmd.highlight("default link IndentLine Comment")
    --     end,
    -- },

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
}

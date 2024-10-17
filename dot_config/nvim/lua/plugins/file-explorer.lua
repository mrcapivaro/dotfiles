return {
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
}

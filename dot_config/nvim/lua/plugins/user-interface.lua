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
              vim.api.nvim_win_set_config(win, { border = vim.g.FloatBorders })
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
        command_palette = true,
        lsp_doc_border = true,
        long_message_to_split = false,
      },
      views = {
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

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "UiEnter",
    opts = {
      indent = { char = "│" },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    after = "catppuccin",
    event = "UiEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.configs.lualine")
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

  -- {
  --   "SmiteshP/nvim-navic",
  --   event = "BufReadPost",
  --   config = function()
  --     require("nvim-navic").setup({
  --       -- icons = require("lspkind").symbol_map,
  --       separator = "",
  --       icons = require("lsp.init").symbol_icons,
  --     })
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       callback = function(args)
  --         local bufnr = args.buf
  --         local client = vim.lsp.get_client_by_id(args.data.client_id)
  --         -- if not vim.tbl_contains({ "copilot", "null-ls", "ltex" }, client.name) then
  --         --   require("nvim-navic").attach(client, bufnr)
  --         -- end
  --         require("nvim-navic").attach(client, bufnr)
  --       end,
  --     })
  --   end,
  -- },
}

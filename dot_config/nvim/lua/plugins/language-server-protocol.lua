return {
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
          local items = require("tools").lspconfig.items
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
      require("plugins.configs.lsp.lspconfig")
    end,
  },

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
      require("plugins.configs.lsp.null-ls")
    end,
  },
}

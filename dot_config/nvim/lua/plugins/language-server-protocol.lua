return {
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
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("plugins.configs.lsp.mason-lspconfig")
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("plugins.configs.lsp.mason-null-ls")
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.lsp.null-ls")
    end,
  },
}

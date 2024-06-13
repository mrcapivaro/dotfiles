return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function()
      local lsp_servers = require("custom.lsp_servers")
      local opts = {
        ensure_installed = lsp_servers.mason,
      }
      return opts
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require("custom.configs.none-ls")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require("custom.configs.treesitter")
      local lsp_servers = require("custom.lsp_servers")
      opts.ensure_installed = vim.tbl_extend("keep", lsp_servers.treesitter, opts.ensure_installed)
      return opts
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "css", "html", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  {
    "CRAG666/code_runner.nvim",
    -- lazy = "VeryLazy",
    lazy = false,
    opts = {
      mode = "float",
      float = {
        border = "single",
      },
      filetype = {
        -- python = "python -u '$dir/$fileName'"
        python = "python -u",
      },
    },
  },

  {
    "tpope/vim-fugitive",
  },

  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    {
      "epwalsh/pomo.nvim",
      version = "*",
      lazy = true,
      cmd = { "TimerStart", "TimerRepeat" },
      -- dependencies = { "nvim-notify" },
      opts = {
        notifiers = {
          sticky = false,
        },
      },
    },

    {
      "epwalsh/obsidian.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      version = "*",
      lazy = true,
      ft = { "markdown" },
      opts = {
        workspaces = {
          {
            name = "personal",
            path = "/mnt/c/Users/MrCapivaro/My Drive/AutoSync/obsidian/mrcapivaro/",
          },
        },
      },
    },
  },

  {
    "MrCapivaro/live-server.nvim",
    ft = { "html", "css", "javascript", "typescript" },
    cmd = { "LiveServerStart", "LiveServerStop" },
    keys = {
      {
        "<A-l><A-o>",
        "<cmd>LiveServerStart<cr>",
        desc = "Open Live Server",
      },
      {
        "<A-l><A-c>",
        "<cmd>LiveServerStop<cr>",
        desc = "Open Live Server",
      },
    },
    opts = {
      -- windows = true,
      args = {
        "--browser=wslview",
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-symbols.nvim" },
  },

  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        css = true,
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = function()
      local opts = require("plugins.configs.others").blankline
      opts.indent = { char = "⎸" }
      return opts
    end,
  },
}

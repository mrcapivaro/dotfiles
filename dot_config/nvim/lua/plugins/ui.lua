local filetypes = {
  "css",
  "html",
  "javascript",
  "typescript",
  "jsx",
}

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = function()
      local noice = require("noice")
      return {
        options = {
          theme = "catppuccin",
          component_separators = "",
          section_separators = "",
          ignore_focus = {
            "neo-tree"
          },
          disabled_filetypes = {
            statusline = {
              "neo-tree",
            },
            winbar = {
              "neo-tree",
            },
          },
        },
        sections = {
          lualine_x = {
            "encoding",
            "fileformat",
            "filetype",
            function()
              local ok, pomo = pcall(require, "pomo")
              if not ok then
                return ""
              end
              local timer = pomo.get_first_to_finish()
              if timer == nil then
                return ""
              end
              return " " .. tostring(timer)
            end,
            {
              noice.api.statusline.mode.get,
              cond = noice.api.statusline.mode.has,
            },
          },
        },
      }
    end
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    config = function()
      local bufferline = require("bufferline")
      require("bufferline").setup({
        options = {
          style_preset = { bufferline.style_preset.minimal },
          diagnostics = "nvim_lsp",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              text_align = "center",
              -- highlight = "Directory",
            },
          },
        },
      })
    end,
  },

  {
    "stevearc/dressing.nvim",
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      render = "wrapped-compact",
      stages = "static",
      fps = 1,
      top_down = false,
      timeout = 1000,
    },
  },

  {
    "folke/noice.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify"
    },
    event = "VeryLazy",
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("ibl").setup({
        -- indent = { char = "│" },
        indent = { char = "⎸" },
        scope = {
          show_start = false,
          show_end = false,
        },
      })
    end,
  },

  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    ft = filetypes,
    opts = {
      css = true,
      css_fn = true,
    },
    config = function(_, opts)
      require("colorizer").setup(filetypes, opts)
    end
  },

  {
    "shortcuts/no-neck-pain.nvim",
    keys = {
      {
        "<leader>z",
        "<cmd>NoNeckPain<cr>",
        desc = "Enable NoNeckPain mode."
      },
    },
    opts = {
      buffers = {
        right = {
          enabled = false,
        },
      },
      width = 70,
    },
  },
}

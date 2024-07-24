return {
  {
    "mrcapivaro/true-zen.nvim",
    opts = {
      integrations = {
        lualine = true,
      },
    },
    config = function(_, opts)
      require("true-zen").setup(opts)
    end,
    keys = {
      {
        "<leader>za",
        "<cmd>TZAtaraxis<cr>",
        mode = "n",
        desc = "Toggle Ataraxis zen mode.",
        noremap = true,
      },
      {
        "<leader>zf",
        "<cmd>TZFocus<cr>",
        mode = "n",
        desc = "Toggle Focus zen mode.",
        noremap = true,
      },
      {
        "<leader>zm",
        "<cmd>TZMinimalist<cr>",
        mode = "n",
        desc = "Toggle Minimalist zen mode.",
        noremap = true,
      },
      {
        "<leader>zn",
        "<cmd>TZNarrow<cr>",
        mode = "n",
        desc = "Toggle Narrow zen mode.",
        noremap = true,
      },
    },
  },

  {
    "jbyuki/venn.nvim",
    keys = {
      {
        "f",
        ":VBox<cr>",
        mode = "v",
        desc = "Draw a box around the selected region.",
      },
    },
  },

  -- does not work on windows:
  -- kitty is not supported for windows
  -- and ueberzugcc also
  -- {
  --   "3rd/image.nvim",
  --   opts = {},
  -- },

  {
    "nvim-neorg/neorg",
    lazy = false,
    version = "*",
    config = function()
      require("neorg").setup({
        -- https://github.com/nvim-neorg/neorg/wiki
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = { org = "~/org" },
              default_workspace = "org",
              index = "index.norg",
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {},
          -- does not work on windows: needs image.nvim
          -- ["core.latex.renderer"] = {},
          ["core.presenter"] = {
            config = {
              zen_mode = "truezen",
            },
          },
          ["core.summary"] = {},
          ["core.text-objects"] = {},
        },
      })
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}

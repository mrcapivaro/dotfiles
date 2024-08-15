return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Neotree left toggle<cr>",
      desc = "File explorer toggle."
    },
  },
  opts = {
    window = {
      width = 30,
    },
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        visible = true,
        shiw_hidden_content = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
    },
  },
}

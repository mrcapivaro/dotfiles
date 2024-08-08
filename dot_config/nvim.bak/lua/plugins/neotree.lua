return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>e",
      "<cmd>Neotree left toggle<cr>",
      desc = "File explorer"
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        shiw_hidden_content = true,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          -- ".git",
          -- ".DS_Store",
          -- "thumbs.db"
        },
        never_show = {},
      },
    },
  },
}

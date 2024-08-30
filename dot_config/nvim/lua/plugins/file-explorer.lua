return {
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
}

return {
  "nvim-telescope/telescope.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  keys = function()
    local telescope = require("telescope.builtin")
    return {
      {
        "<leader>ff",
        telescope.find_files,
        desc = "Fuzzy find files in the current working directory.",
      },
      {
        "<leader>f?",
        telescope.keymaps,
        desc = "Show keymaps through fzf interface.",
      },
      {
        "<leader>fs",
        telescope.symbols,
        desc = "Show symbols through fzf interface.",
      },
      {
        "<leader>fw",
        telescope.live_grep,
        desc = "Live grep a string in the cwd through fzf interface.",
      },
      {
        "<leader>fc",
        telescope.colorscheme,
        desc = "Live grep a string in the cwd through fzf interface.",
      },
      {
        "<leader>fn",
        "<cmd>Telescope notify<cr><esc>",
        desc = "Show notifications list through fzf interface.",
      },
    }
  end,
}

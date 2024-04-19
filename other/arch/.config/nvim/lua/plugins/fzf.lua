return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
  },
  cmd = { "Telescope" },
  keys = function()
    local telescope = require("telescope.builtin")
    return {
      {
        "<leader>ff",
        telescope.find_files,
        desc = "Find files in cwd."
      },
      {
        "<leader>?",
        telescope.keymaps,
        desc = "Show keymaps."
      },
      {
        "<leader>fs",
        telescope.symbols,
        desc = "Show symbols helper.",
      },
      {
        "<leader>fg",
        telescope.live_grep,
        desc = "Live grep a string.",
      },
      {
        "<leader>/",
        telescope.current_buffer_fuzzy_find,
        desc = "Find string in current buffer.",
      },
    }
  end,
}

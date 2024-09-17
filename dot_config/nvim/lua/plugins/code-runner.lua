return {
  {
    "stevearc/overseer.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        -- direction = "bottom",
        -- min_height = 25,
        -- max_height = 25,
        -- default_detail = 1,
        bindings = {
          ["q"] = "Close",
        },
      },
      form = { border = "single" },
      confirm = { border = "single" },
      task_win = { border = "single" },
      help_win = { border = "single" },
    },
  },

  {
    "Zeioth/compiler.nvim",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
    keys = {
      {
        "<leader>ro",
        "<cmd>CompilerOpen<cr>",
        desc = "Open Compiler.nvim telescope prompt.",
      },
      {
        "<leader>rr",
        "<cmd>CompilerRedo<cr>",
        desc = "Redo last Compiler.nvim task.",
      },
      {
        "<leader>rt",
        "<cmd>CompilerToggleResults<cr>",
        desc = "Toggle Compiler.nvim results.",
      },
    },
  },
}

return {
  { -- The task runner we use
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1,
      },
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

return {
  "Zeioth/compiler.nvim",
  dependencies = {
    {
      "stevearc/overseer.nvim",
      opts = {
        task_list = { -- this refers to the window that shows the result
          direction = "bottom",
          min_height = 25,
          max_height = 25,
          default_detail = 1,
          bindings = {
            ["q"] = function()
              vim.cmd("OverseerClose")
            end,
          },
        },
      },
      config = function(_, opts)
        require("overseer").setup(opts)
      end,
    },
  },
  cmd = { "CompilerOpen", "CompilerToggleResults" },
  keys = {
    {
      "<leader>ro",
      "<cmd>CompilerOpen<cr><esc>",
      desc = "Open Compiler.nvim",
    },
    {
      "<leader>rr",
      "<cmd>CompilerStop<cr>" .. "<cmd>CompilerRedo<cr>",
      desc = "Redo last Compiler.nvim task",
    },
    {
      "<leader>rt",
      "<cmd>CompilerToggleResults<cr>",
      desc = "Redo last Compiler.nvim task",
    },
  },
  opts = {},
}

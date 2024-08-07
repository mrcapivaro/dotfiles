return {
  "CRAG666/code_runner.nvim",
  lazy = false,
  keys = {
    {
      "<leader>r",
      function()
        require("code_runner").run_code()
      end,
      desc = "Run Code."
    },
  },
  opts = {
    mode = "float",
    float = {
      border = "single",
    },
    filetype = {
      ps1 = "pwsh --command",
    },
  },
}

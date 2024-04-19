return {
  "CRAG666/code_runner.nvim",
  keys = {
    {
      "<leader>rr",
      function()
        require("code_runner").run_code()
      end,
      desc = "Run code"
    },
  },
  opts = {
    mode = "float",
    float = {
      border = "single",
    },
    filetype = {
      -- python = "python -u '$dir/$fileName'"
      python = "python -u"
    },
  },
}

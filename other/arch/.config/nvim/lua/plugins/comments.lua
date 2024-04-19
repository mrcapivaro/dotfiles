return {

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = { ignore = "^$" },
  },

  {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

}

return {
  {
    "epwalsh/pomo.nvim",
    version = "*",
    lazy = true,
    cmd = { "TimerStart", "TimerRepeat" },
    dependencies = { "nvim-notify" },
    opts = {
      notifiers = {
        sticky = false,
      },
    },
  },

  {
    "epwalsh/obsidian.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    version = "*",
    lazy = true,
    ft = { "markdown" },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "/mnt/c/Users/MrCapivaro/My Drive/AutoSync/obsidian/mrcapivaro/",
        }
      },
    },
  },
}

return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop" },
  keys = {
    {
      "<A-l><A-o>",
      "<cmd>LiveServerStart<cr>",
      desc = "Open Live Server",
    },
    {
      "<A-l><A-c>",
      "<cmd>LiveServerStop<cr>",
      desc = "Open Live Server",
    },
  },
  opts = {
    args = {
      "--browser=wslview",
    },
  },
}

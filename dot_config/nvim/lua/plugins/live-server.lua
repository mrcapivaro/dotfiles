return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  keys = {
    {
      "<leader>ls",
      "<cmd>LiveServerToggle<cr>",
      desc = "Toggle Live Server",
    },
  },
  opts = {
    -- args = {
    --   "--browser=wslview",
    -- },
  },
}

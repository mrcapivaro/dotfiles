return {
  "barrett-ruth/live-server.nvim",
  build = "pnpm add -g live-server",
  cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
  keys = {
    {
      "<leader>lo",
      "<cmd>LiveServerToggle<cr>",
      desc = "Toggle Live Server",
    },
  },
  opts = function()
    local t = {}
    -- check for a WSL2 system
    if vim.fn.filereadable("/proc/sys/fs/binfmt_misc/WSLInterop") == 1 then
      t = {
        args = {
          "--browser=wslview",
        },
      }
    end
    return t
  end,
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = { { import = "plugins" } },
  install = { colorscheme = { "catppuccin", "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrwPlugin",
        "matchit"
      },
    },
  },
})

vim.keymap.set({ "n", "v", "s" }, "<leader>l", "<cmd>Lazy<cr>", { desc = "Open the Lazy plugin manager menu." })

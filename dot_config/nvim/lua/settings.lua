---User Interface
vim.g.FloatBorders = "single" -- { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
require("statusline")
local statusline = {
  " %t",
  "%r",
  "%m",
  "%=",
  "%{&filetype}",
  " %2p%%",
  " %3l:%-2c ",
}
vim.o.statusline = table.concat(statusline, "")

---Keymap Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

---Vim Options
local vim_opt = {
  clipboard = "unnamedplus",
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  smartindent = true,
  termguicolors = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  wrap = false,
  list = true,
  showmode = false,
  completeopt = "menu,menuone,noselect",
  cmdheight = 0,
  colorcolumn = "88",
  shellslash = false,
  hlsearch = true,
  incsearch = true,
  autowrite = true,
  swapfile = false,
  backup = false,
  ignorecase = true,
  spelllang = { "en_US.UTF-8" },
  scrolloff = 16,
  sidescrolloff = 8,
  updatetime = 50,
  virtualedit = "block",
  conceallevel = 2,
  concealcursor = "nc",
  cursorline = true,
}

for k, v in pairs(vim_opt) do
  vim.opt[k] = v
end

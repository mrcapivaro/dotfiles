---User Interace
vim.g.FloatBorders = "single" -- { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
require("statusline")

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
  completeopt = "menu,menuone,noselect",
  showmode = true,
  cmdheight = 2,
  colorcolumn = "80",
  -- shellslash = false,
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

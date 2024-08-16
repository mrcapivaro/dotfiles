vim.g.mapleader = " "
vim.g.maplocalleader = ","
-- vim.g.FloatBorders = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
vim.g.FloatBorders = "single" -- same as the above

vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.showmode = false
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.cmdheight = 0
-- vim.opt.colorcolumn = "88"
-- vim.opt.shellslash = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.spelllang = { "en" }
vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 50
vim.opt.virtualedit = "block"
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"

vim.cmd("language en_US")

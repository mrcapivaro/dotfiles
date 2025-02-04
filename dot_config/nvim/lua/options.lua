vim.cmd("language en_US.utf-8")

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autochdir = false
vim.opt.path:append("**")
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.showmode = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "81"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.encoding = "utf-8"
vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 50
vim.opt.virtualedit = "block"
vim.opt.conceallevel = 2
vim.opt.cursorline = true
vim.opt.clipboard = "unnamedplus"

--: Leader Key
vim.g.mapleader = " "
vim.g.maplocalleader = "s"
vim.opt.timeoutlen = 2000

--: Statusline
vim.opt.laststatus = 3

--: Folds
--: https://www.reddit.com/r/neovim/comments/1d3iwcz/custom_folds_without_any_plugins/
vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 0
vim.opt.foldcolumn = "auto:1"
-- vim.opt.foldminlines = 16
vim.opt.fillchars:append("fold:-")

--: Indenting and Whitespace
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.listchars = { space = ".", tab = ">.", eol = "~" }

--: Conceal is normal and command mode, but not on the cursorline.
vim.opt.concealcursor:remove("n")

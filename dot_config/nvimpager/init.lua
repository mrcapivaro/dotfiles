-- ~/.config/nvimpager/init.lua

---Colorscheme
local colorscheme = "gruvbox"
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/" .. colorscheme)
vim.cmd.colorscheme(colorscheme)

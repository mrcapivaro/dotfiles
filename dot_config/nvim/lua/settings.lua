---User Interace
vim.g.FloatBorders = "single" -- { "┌", "─", "┐", "│", "┘", "─", "└", "│" }

---Keymap Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = ","

---Listchars
-- vim.api.nvim_set_hl(0, "Whitespace", { fg = "#313244" })
-- vim.opt.listchars = { space = "·", tab = "> " }
-- vim.opt.listchars = { space = "·", tab = "> ", eol = "␤" }

---Vim Options
local vim_opt = {
    clipboard = "unnamedplus",
    shiftwidth = 4,
    tabstop = 4,
    softtabstop = 4,
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

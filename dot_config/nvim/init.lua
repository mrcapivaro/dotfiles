-- mrcapivaro's neovim config

-- Options {{{1

-- Folding {{{2

vim.opt.foldmethod = "marker"
vim.opt.foldlevel = 0
vim.opt.foldcolumn = "auto:1"
vim.opt.fillchars:append("fold: ")

-- https://www.reddit.com/r/neovim/comments/1d3iwcz/custom_folds_without_any_plugins/
FoldText = function()
    local foldend = vim.v.foldend
    local foldstart = vim.v.foldstart
    local raw = table.concat(
        vim.fn.getbufline(vim.api.nvim_get_current_buf(), foldstart),
        ""
    )

    local title_patterns = {
        "%s*([%a%s]+)%s:%s{{{", -- }}}
        "%s*([%a%s]+)%s{{{", -- }}}
        "{{{%d*%s*([%a%s]+)", -- }}}
    }
    local title
    for _, pattern in ipairs(title_patterns) do
        title = raw:match(pattern)
        if title then
            break
        end
    end

    local loc = foldend - foldstart
    local level = raw:match("{{{%s*(%d+)") -- }}}
    title = ("*"):rep(level) .. " " .. title .. (" (%s) "):format(loc)

    local fillerchar = "-"
    local fillersize = 80 - #title - 1
    title = title .. fillerchar:rep(fillersize)

    return title
end

vim.o.foldtext = "v:lua.FoldText()"

-- 2}}}

---Show whitespace characters
vim.opt.listchars = { space = ".", tab = ">.", eol = "~" }

vim.opt.clipboard = "unnamedplus"

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.autochdir = true

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.list = true
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.showmode = true
vim.opt.cmdheight = 1
vim.opt.colorcolumn = "81"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autowrite = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.ignorecase = true
vim.opt.spelllang = { "en_US.UTF-8" }
vim.opt.scrolloff = 16
vim.opt.sidescrolloff = 8
vim.opt.updatetime = 50
vim.opt.virtualedit = "block"
vim.opt.conceallevel = 2
vim.opt.cursorline = true

-- Conceal is normal and command mode, but not on the cursorline.
vim.opt.concealcursor:remove("n")

-- 1}}}
-- Keymaps {{{1

-- Leader key options
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.timeoutlen = 2000

-- QoL {{{2

vim.keymap.set(
    { "n", "v", "s" },
    "<leader>re",
    ":<Up><cr>",
    { desc = "Run last ex command." }
)

vim.keymap.set(
    { "n", "i", "v", "s" },
    "<C-s>",
    "<cmd>w<cr>",
    { desc = "Write buffer changes." }
)

vim.keymap.set(
    { "n", "v", "s" },
    "<leader>q",
    "ZQ",
    { desc = "Quit without writing." }
)

vim.keymap.set(
    { "i", "n" },
    "<esc>",
    "<cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch." }
)

vim.keymap.set(
    { "i", "v", "c", "x", "n" },
    "<C-g>",
    "<esc>",
    { desc = "Exit insert mode with one hand." }
)

vim.keymap.set(
    { "i", "n" },
    "<C-g>",
    "<cmd>noh<cr><esc>",
    { desc = "Escape and clear hlsearch." }
)

-- Move LoC
vim.keymap.set("v", "<S-k>", "<cmd>m+1<cr>vv")
vim.keymap.set("v", "<S-j>", "<cmd>m-2<cr>vv")
vim.keymap.set("x", "<S-k>", ":m '<-2<cr>gv=gv")
vim.keymap.set("x", "<S-j>", ":m '>+1<cr>gv=gv")

-- Better Indent
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")

-- Movement
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- 2}}}
-- Buffers {{{2

vim.keymap.set(
    { "n", "v", "s" },
    "L",
    "<cmd>bn<cr>",
    { desc = "Next buffer." }
)

vim.keymap.set(
    { "n", "v", "s" },
    "H",
    "<cmd>bp<cr>",
    { desc = "Previous buffer." }
)

vim.keymap.set(
    { "n", "v", "s" },
    "<leader>bd",
    "<cmd>bd<cr>",
    { desc = "Close buffer." }
)

vim.keymap.set(
    { "n", "v", "s" },
    "<leader>bD",
    "<cmd>bd!<cr>",
    { desc = "Force close buffer." }
)

-- 2}}}
-- Folding {{{2

vim.keymap.set(
    { "n", "v", "s", "x" },
    "<tab>",
    "za",
    { desc = "Toggle folding." }
)

-- 2}}}
-- Window splits {{{2

vim.keymap.set(
    { "n", "v", "s" },
    "<C-w>|",
    "<cmd>vertical split<cr>",
    { desc = "Vertical window split." }
)

vim.keymap.set(
    { "n", "v", "s" },
    "<C-w>\\",
    "<cmd>horizontal split<cr>",
    { desc = "Horizontal window split." }
)

-- 2}}}

-- 1}}}
-- Commands {{{1

local align_cmd = [[norm gv:!column -o ' ' -L -t<cr>gv=]]
vim.api.nvim_create_user_command("Align", align_cmd, { range = true })

local slint_augroup = vim.api.nvim_create_augroup("slint_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
    group = slint_augroup,
    pattern = { "*.slint" },
    callback = function()
        vim.bo.filetype = "slint"
    end,
})

-- 1}}}

require("plugins")

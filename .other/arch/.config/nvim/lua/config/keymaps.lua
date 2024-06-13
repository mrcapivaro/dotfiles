-- Do not put plugin related keymaps here, instead use
-- the key property of plugins specs.
local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Easy CMD
map({ "n", "v", "s" }, ";", ":", { desc = "Easy cmd." })

-- Save Buffer
map({ "n", "i", "v", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Write buffer changes." })

-- Easy Quit
map({ "n", "v", "s" }, "<leader>q", "ZQ", { desc = "Quit without writing." })

-- Better Screen Movement
map("n", "<C-u>", "<C-u>zz", { desc = "Move screen up." })
map("n", "<C-d>", "<C-d>zz", { desc = "Move screen down." })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch." })

-- Buffer Commands
map({ "n", "v", "s" }, "<Tab>", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, "<S-Tab>", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer." })
map({ "n", "v", "s" }, "<leader>bD", "<cmd>bd!<cr>", { desc = "Force delete buffer." })

-- Built-in File Explorer
map("n", "<leader>e", "<cmd>Ex<cr>", { desc = "Open builtin file explorer." })

local map = vim.keymap.set

-- QoL
map({ "n", "v", "s" }, ";", ":", { desc = "Faster cmd." })
map({ "n", "i", "v", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Write buffer changes." })
map({ "n", "v", "s" }, "<leader>q", "ZQ", { desc = "Quit without writing." })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch." })

-- Movement
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "j", "jzz")
map("n", "k", "kzz")

-- Buffers
map({ "n", "v", "s" }, "<Tab>", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, "<S-Tab>", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer." })
map({ "n", "v", "s" }, "<leader>bD", "<cmd>bd!<cr>", { desc = "Force close buffer." })

-- Windows
map({ "n", "v", "s" }, "|", "<cmd>vertical split<cr>", { desc = "Vertical window split." })
map({ "n", "v", "s" }, "\\", "<cmd>horizontal split<cr>", { desc = "Horizontal window split." })

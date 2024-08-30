local map = vim.keymap.set

-- QoL
map({ "n", "i", "v", "s" }, "<C-s>", "<cmd>w<cr>", { desc = "Write buffer changes." })
map({ "n", "v", "s" }, "<leader>q", "ZQ", { desc = "Quit without writing." })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch." })

-- Move LoC
map("v", "<S-k>", "<cmd>m+1<cr>vv")
map("v", "<S-j>", "<cmd>m-2<cr>vv")
map("x", "<S-k>", ":m '<-2<cr>gv=gv")
map("x", "<S-j>", ":m '>+1<cr>gv=gv")

-- Better Indent
map("x", ">", ">gv")
map("x", "<", "<gv")

-- Movement
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")

-- Buffers
map({ "n", "v", "s" }, "<Tab>", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, "<S-Tab>", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, "[b", "<cmd>bn<cr>", { desc = "Next buffer." })
map({ "n", "v", "s" }, "]b", "<cmd>bp<cr>", { desc = "Previous buffer." })
map({ "n", "v", "s" }, "<leader>bd", "<cmd>bd<cr>", { desc = "Close buffer." })
map({ "n", "v", "s" }, "<leader>bD", "<cmd>bd!<cr>", { desc = "Force close buffer." })

-- Windows
map({ "n", "v", "s" }, "|", "<cmd>vertical split<cr>", { desc = "Vertical window split." })
map({ "n", "v", "s" }, "\\", "<cmd>horizontal split<cr>", { desc = "Horizontal window split." })

-- Other
map({ "n", "v", "s" }, "<C-P>", ":")


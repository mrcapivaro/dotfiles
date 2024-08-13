local map = vim.keymap.set

map("n", "<leader>P", function() require("powershell").toggle_term() end)
map("n", "<leader>E", function() require("powershell").eval() end)

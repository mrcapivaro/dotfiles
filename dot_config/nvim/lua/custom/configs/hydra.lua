-- Docs: https://github.com/anuvyklack/hydra.nvim

local hydra = require("hydra")
-- local cmd = require("hydra.keymap-util").cmd
-- local pcmd = require("hydra.keymap-util").pcmd

-- Window resizing {{{

hydra({
    name = "Window resizing",
    config = { hint = { type = "window", border = "single" } },
    mode = "n",
    body = "<C-w>",
    heads = {
        { "H", "<C-w>>" },
        { "J", "<C-w>-" },
        { "K", "<C-w>+" },
        { "L", "<C-w><" },
        { "=", "<C-w>=" },
    },
})

-- }}}
-- Diagrams (venn.nvim) {{{

hydra({
    name = "Diagrams (venn.nvim)",
    config = {
        hint = { type = "window", border = "single" },
        invoke_on_body = true,
        color = "pink",
        on_enter = function()
            vim.o.virtualedit = "all"
        end,
    },
    mode = { "n", "v" },
    body = "<leader>d",
    heads = {
        { "H", "<C-v>h:VBox<CR>" },
        { "J", "<C-v>j:VBox<CR>" },
        { "K", "<C-v>k:VBox<CR>" },
        { "L", "<C-v>l:VBox<CR>" },
        { "f", ":VBox<CR>", { mode = "v" } },
        { "<Esc>", nil, { exit = true } },
    },
})

-- }}}

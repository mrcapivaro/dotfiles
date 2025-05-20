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

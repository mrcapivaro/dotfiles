local heirline = require("heirline")
local statusline = require("custom.configs.heirline.statusline")
local winbar = require("custom.configs.heirline.winbar")

heirline.setup({
    statusline = statusline,
    winbar = winbar,
    opts = {
        disable_winbar_cb = function()
            return require("heirline.conditions").buffer_matches({
                buftype = {
                    "acwrite",
                    "nofile",
                    "prompt",
                    "terminal",
                    "quickfix",
                },
                -- filetype = {},
            })
        end,
    },
})

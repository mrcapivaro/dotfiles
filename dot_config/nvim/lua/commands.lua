--
-- ~/.config/nvim/lua/commands.lua
--
-- Purpose:
--   User created commands, autocmd's and related.

-- [ Autocommands ] --

-- Detect *.slint files
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("Slint", { clear = true }),
    pattern = "*.slint",
    callback = function()
        vim.bo.filetype = "slint"
    end,
})

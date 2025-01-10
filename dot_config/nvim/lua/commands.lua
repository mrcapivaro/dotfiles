-- ~/.config/nvim/lua/commands.lua

local align_cmd = [[norm gv:!column -o ' ' -L -t<cr>gv=]]
vim.api.nvim_create_user_command("Align", align_cmd, { range = true })

local custom_filetypes = { "slint" }

for _, ft in ipairs(custom_filetypes) do
    vim.api.nvim_create_autocmd({ "BufEnter", "BufNew" }, {
        group = vim.api.nvim_create_augroup(ft .. "_ft", { clear = true }),
        pattern = { "*." .. ft },
        callback = function() vim.bo.filetype = ft end,
    })
end

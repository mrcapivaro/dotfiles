local align_cmd = [[norm gv:!column -o ' ' -L -t<cr>gv=]]
vim.api.nvim_create_user_command("Align", align_cmd, { range = true })

vim.filetype.add({
    extension = {
        -- rust ui library
        slint = "slint",
        dj = "djot",
    },
})

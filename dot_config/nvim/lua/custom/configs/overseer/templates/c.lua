return {
    name = "C Build",
    builder = function()
        local file = vim.fn.expand("%:p")
        local filename = vim.fn.fnamemodify(file, ":t:r")
        return {
            cmd = { "gcc" },
            args = {
                "-o",
                filename,
                file,
                -- "&&",
                -- "./" .. filename,
            },
            components = { { "on_output_quickfix", open = true }, "default" },
        }
    end,
    condition = { filetype = { "c" } },
}

local tools = require("custom.configs.tools")

---Server Setup
require("mason-lspconfig").setup({
    automatic_installation = false,
    ensure_installed = tools.lspconfig.items,
    handlers = tools.lspconfig.handlers,
})

---Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP keymaps/actions.",
    callback = function(event)
        local opts = { buffer = event.buf }
        local map = vim.keymap.set

        map("n", ",r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
        map("n", ",a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
        map({ "n", "x" }, ",f", function()
            vim.lsp.buf.format({ async = false })
        end, opts)
        map("n", ",l", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
        map("n", ",d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
        map("n", ",D", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
        map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    end,
})

---Floating document windows
-- Use non-rounded simple borders
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "single",
})
vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "single",
    })

-- Use the default highlights for the lsp hover
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "", fg = "" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "", fg = "" })

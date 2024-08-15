-- Server Setup
local tools = require("tools").lspconfig
require("mason-lspconfig").setup({
  automatic_installation = false,
  ensure_installed = tools.items,
  handlers = tools.handlers,
})

-- Keymaps
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP keymaps/actions.",
  callback = function(event)
    local opts = { buffer = event.buf }
    local map = vim.keymap.set
    map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    map("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    map({ "n", "x" }, "<leader>lf", function()
      vim.lsp.buf.format({ async = false })
    end, opts)
    map("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    map("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
    map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
    map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
  end,
})

local lspconfig = require("lspconfig")

-- Server Setup
local servers = require("ensure-installed").lspconfig
for _, server in ipairs(servers) do
  lspconfig[server].setup({})
end

-- UI
vim.diagnostic.config({
  float = { border = vim.g.FloatBorders },
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  -- border = vim.g.FloatBorders,
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    -- border = vim.g.FloatBorders,
    border = "single",
  })

require("lspconfig.ui.windows").default_options = {
  border = vim.g.FloatBorders,
}

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

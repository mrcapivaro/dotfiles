local M = {}

M.lspconfig = {
  "lua_ls",
  "html",
  "cssls",
  "emmet_ls",
  "clangd",
  "pyright",
  "ruff_lsp",
  "bashls",
  "tsserver",
  "gopls",
  "taplo"
}

M.none_ls = {
  formatters = {
    "stylua",
    "shfmt",
    "prettierd",
  },
  -- linters = {},
}

M.debug_adapters = {
  "codelldb",
}

return M

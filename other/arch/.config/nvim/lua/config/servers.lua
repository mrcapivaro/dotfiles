local M = {}

-- link to lspconfig server names:
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
M.lsp = {
  "lua_ls",
  "nil_ls",
  "html",
  "cssls",
  "emmet_ls",
  "clangd",
  "pyright",
  "ruff_lsp",
  "bashls",
  "tsserver",
  -- "eslint-lsp", -- js/ts linter lsp
}

M.formatter = {
  "shfmt",    -- shell
  "stylua",   -- lua
  "prettierd", -- html, css and js
  "ruff-lsp", -- python formatter lsp
}

M.dap = {
  "codelldb", -- C
}

return M

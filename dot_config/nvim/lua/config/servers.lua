local M = {}

-- link to lspconfig server names:
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
M.lsp = {
  "lua_ls",
  -- "nil_ls", -- needs nix installed
  "html",
  "cssls",
  "emmet_ls",
  "clangd",
  "pyright",
  "ruff_lsp", -- python formatter lsp
  "bashls",
  "tsserver",
  -- "eslint_lsp", -- js/ts linter lsp
  "gopls",
  "taplo"
}

M.formatter = {
  "shfmt", -- shell
  "stylua", -- lua
  "prettierd", -- html, css and js
}

M.dap = {
  "codelldb", -- C
}

return M

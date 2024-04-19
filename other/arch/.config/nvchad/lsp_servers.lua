local M = {}

-- run MasonInstall in cmd to search for names
M.mason = {
  "lua-language-server",
  "stylua",
  -- web dev --
  "html-lsp",
  "css-lsp",
  "emmet-ls",
  "typescript-language-server",
  "tailwindcss-language-server",
  "prettier",
  "eslint-lsp",
  -- c & c++ --
  "clangd",
  "clang-format",
  "codelldb",
  -- python --
  "pyright",
  "autopep8",
  -- go --
  -- rust --
  -- nix? --
  -- other --
  "taplo",
  "bash-language-server",
  "beautysh",
}

-- run TSInstall in cmd to search for names
M.treesitter = {
  -- vim --
  "vim",
  "vimdoc",
  "query",
  -- lua --
  "lua",
  "luadoc",
  "luap",
  -- shell
  "bash",
  -- notes --
  "markdown",
  "markdown_inline",
  -- "norg",
  -- "org",
  -- web dev --
  "html",
  "css",
  "javascript",
  "typescript",
  "tsx",
  -- other --
  "c",
  "cpp",
  "rust",
  "go",
  "python",
  -- config --
  "toml",
  "yaml",
  "ini",
  "json",
}

-- made obsolute by mason lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
M.lspconfig = {
  -- web dev --
  "html",
  "cssls",
  "emmet_ls",
  "tsserver",
  "tailwindcss",
  "eslint",
  -- c & c++ --
  "clangd",
  -- python --
  "pyright",
  -- go --
  -- rust --
  -- nix? --
  -- config --
  "taplo",
  "bashls",
}

-- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
-- remember to add formatters and linters to /custom/configs/none-ls.lua

return M

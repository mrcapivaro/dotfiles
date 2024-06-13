local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier.with({
      disabled_filetypes = { "html" },
    }),
    null_ls.builtins.formatting.clang_format,
    null_ls.builtins.formatting.autopep8,
    null_ls.builtins.formatting.beautysh.with({
      extra_args = {"-i", "2"},
    }),
    -- null_ls.builtins.code_actions.eslint,
  },
  -- on_attach = function(client, bufnr)
  --   if client.supports_method "textDocument/formatting" then
  --     vim.api.nvim_clear_autocmds {
  --       group = augroup,
  --       buffer = bufnr,
  --     }
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format {
  --           async = false,
  --           bufnr = bufnr,
  --           filter = function(client)
  --             return client.name == "null-ls"
  --           end,
  --         }
  --       end,
  --     })
  --   end
  -- end,
}

return opts

return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local formatter = null_ls.builtins.formatting
    -- local linter = null_ls.builtins.diagnostics
    null_ls.setup({
      -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md
      sources = {
        formatter.stylua,
        formatter.nixpkgs_fmt,
        formatter.prettierd.with({
          disabled_filetypes = { "html" },
        }),
        formatter.shfmt.with({
          extra_args = { "-i", "2" },
        }),
      },
    })
  end,
}

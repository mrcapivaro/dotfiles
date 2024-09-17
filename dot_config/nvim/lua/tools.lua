-- Centralized configuration of dev. tools
local M = {}

-- LSPs
M.lspconfig = {
  items = {
    "lua_ls",
    "html",
    "cssls",
    "emmet_ls",
    "clangd",
    "pyright",
    "ruff_lsp",
    -- "hls",
    "bashls",
    "tsserver",
    "taplo",
  },
  handlers = {
    -- Default Handler
    function(server)
      local lspconfig = require("lspconfig")
      local capabilities = vim.tbl_deep_extend(
        "keep",
        require("cmp_nvim_lsp").default_capabilities(),
        lspconfig.util.default_config.capabilities
      )
      -- capabilities.textDocument.completion.completionItem.snippetSupport = true
      lspconfig[server].setup({
        capabilities = capabilities,
      })
    end,
    ["clangd"] = function()
      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--enable-config",
        },
      })
    end,
    ["lua_ls"] = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        workspace = {
          checkThirdParty = false,
          library = vim.tbl_deep_extend(
            "force",
            vim.api.nvim_get_runtime_file("", true),
            {
              "/usr/share/awesome/lib",
              "/usr/share/lua",
            }
          ),
        },
        diagnostics = {
          globals = {
            "awesome",
            "awful",
            "client",
            "screen",
            "tag",
            "root",
          },
        },
        telemetry = { enabled = false },
      })
    end,
  },
}

-- Formatters and Linters as LSPs
M.null_ls = {
  items = {
    "stylua",
    "prettierd",
    "shfmt",
  },
  handlers = {
    -- shfmt = function(source_name, methods)
    --   require("mason-null-ls").default_setup(source_name, methods)
    --   -- local null_ls = require("null-ls")
    --   -- null_ls.register(null_ls.builtins.formatting.shfmt.with({
    --   --   extra_args = { "-i", "2", "-ci" },
    --   -- }))
    -- end,
    prettierd = function(source_name, _)
      -- require("mason-null-ls").default_setup(source_name, methods)
      local null_ls = require("null-ls")
      null_ls.register(null_ls.builtins.formatting[source_name].with({
        disabled_filetypes = { "html" },
      }))
    end,
  },
}

-- Debugging tools
M.nvim_dap = {
  items = {
    "codelldb",
  },
  handlers = {},
}

return M

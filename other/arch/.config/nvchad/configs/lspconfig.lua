local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities
local lspconfig = require("lspconfig")

-- "auto" setup servers with default configs
local lsp_servers = require("custom.lsp_servers")
for _, server in ipairs(lsp_servers.lspconfig) do
  lspconfig[server].setup({
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  })
end

-- manually tweak servers
lspconfig.clangd.setup({
  offset_encoding = "utf-8",
})

lspconfig.tsserver.setup({
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
})

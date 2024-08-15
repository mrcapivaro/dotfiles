-- Server Setup
local tools = require("tools").null_ls
require("mason-null-ls").setup({
  automatic_installation = false,
  ensure_installed = tools.items,
  handlers = tools.handlers,
})

local null_ls = require("null-ls")
null_ls.setup({})

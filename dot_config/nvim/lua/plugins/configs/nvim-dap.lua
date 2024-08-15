local mason_nvim_dap = require("mason-nvim-dap")
local tools = require("tools").nvim_dap.items
mason_nvim_dap.setup({
  ensure_installed = tools,
  automatic_installation = false,
  handlers = {},
})

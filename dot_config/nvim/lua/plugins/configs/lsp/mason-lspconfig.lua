local mason_lspconfig = require("mason-lspconfig")

function install(command, list)
  vim.cmd(command .. table.concat(list, " "))
end

local M = {
  plugins = false,
  base_colorscheme = "habamax",
}

M.start = function()
  vim.cmd([[colorscheme ]] .. M.base_colorscheme)
  vim.cmd([[language en_US.UTF-8]])
  require("config.keymaps")
  require("config.options")
  if M.plugins then
    require("config.lazy")
  end
end

return M

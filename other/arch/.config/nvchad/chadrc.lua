---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "one_light" },
  transparency = true,
  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
  },
}
M.plugins = "custom.plugins"
M.mappings = require("custom.mappings")

require("custom.options")

return M

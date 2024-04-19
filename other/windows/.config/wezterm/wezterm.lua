local M = {}
local wezterm = require("wezterm")

M.color_scheme = "Catppuccin Mocha"
M.window_close_confirmation = "NeverPrompt"
M.font = wezterm.font({
  family = "FantasqueSansM Nerd Font",
  weight = 400,
})
M.font_size = 16
-- M.window_background_opacity = 0.95
M.use_fancy_tab_bar = false
M.tab_bar_at_bottom = false
M.window_decorations = "INTEGRATED_BUTTONS" .. "|" .. "RESIZE"
M.integrated_title_button_style = "Windows"

return M

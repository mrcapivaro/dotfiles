--
-- ~/.config/awesome/themes/catppuccin/theme.lua
--

local M = {}
local gears = require("gears")
-- local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

M.flavour = "mocha"
M.colors = require("themes.catppuccin.flavours." .. M.flavour)

-- {{{ Beautiful Variables
M.path = gears.filesystem.get_configuration_dir() .. "/themes/catppuccin"
M.font = "IosevkaCapy Nerd Font Bold 12"
M.useless_gap = dpi(0)
M.border_width = dpi(1)
M.border_normal = M.colors.base
M.border_focus = M.colors.mauve
M.border_marked = M.colors.mauve
M.wallpaper = M.path .. "/mountains.png"
M.awesome_icon = "/usr/share/void-artwork/splash.png"
-- }}}

-- {{{ Wibar
M.fg_normal = M.colors.text
M.fg_focus = M.colors.mauve
M.fg_urgent = M.colors.text
M.bg_normal = M.colors.crust
M.bg_focus = M.colors.crust
M.bg_urgent = M.colors.red
-- }}}

-- {{{ Tasklist Widget
M.tasklist_bg_focus = M.colors.base
M.tasklist_disable_task_name = true
M.tasklist_disable_icon = false
M.tasklist_plain_task_name = true
-- M.tasklist_shape = gears.shape.rectangle()
-- }}}

-- {{{ Systray Widget
M.systray_icon_spacing = 8
-- M.bg_systray = M.colors.crust
-- }}}

-- {{{ Titlebar Widget
M.titlebar_bg_focus = M.bg_focus
M.titlebar_bg_normal = M.bg_normal
M.titlebar_fg_focus = M.fg_focus
-- }}}

-- {{{ Menu Widget
M.menu_height = dpi(32)
M.menu_width = dpi(240)
-- }}}

return M

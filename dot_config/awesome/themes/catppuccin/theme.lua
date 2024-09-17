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

-- {{{ Icons
local themes_path = gears.filesystem.get_themes_dir()
M.menu_submenu_icon = themes_path.."default/submenu.png"
M.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
M.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"
M.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
M.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"
M.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
M.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
M.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
M.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"
M.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
M.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
M.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
M.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"
M.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
M.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
M.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
M.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"
M.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
M.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
M.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
M.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"
M.wallpaper = themes_path.."default/background.png"

-- You can use your own layout icons like this:
M.layout_fairh = themes_path.."default/layouts/fairhw.png"
M.layout_fairv = themes_path.."default/layouts/fairvw.png"
M.layout_floating  = themes_path.."default/layouts/floatingw.png"
M.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
M.layout_max = themes_path.."default/layouts/maxw.png"
M.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
M.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
M.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
M.layout_tile = themes_path.."default/layouts/tilew.png"
M.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
M.layout_spiral  = themes_path.."default/layouts/spiralw.png"
M.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
M.layout_cornernw = themes_path.."default/layouts/cornernww.png"
M.layout_cornerne = themes_path.."default/layouts/cornernew.png"
M.layout_cornersw = themes_path.."default/layouts/cornersww.png"
M.layout_cornerse = themes_path.."default/layouts/cornersew.png"
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

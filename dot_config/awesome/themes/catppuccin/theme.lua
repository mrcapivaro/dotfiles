-- Catppuccin Theme for AwesomeWM

awesome.set_preferred_icon_size(32)

local gears = require("gears")
-- local wibox = require("wibox")
-- local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

M.default_path = gears.filesystem.get_themes_dir()
M.path = gears.filesystem.get_configuration_dir() .. "/themes/catppuccin"

M.flavour = "mocha"
M.colors = require("themes.catppuccin.flavours." .. M.flavour)

M.useless_gap = 0
M.wallpaper = M.path .. "/mountains.png"

-- | Font | --
M.font_name = "IosevkaCapy Nerd Font"
M.font_style = "Bold"
M.font_size = 12
M.font = M.font_name .. " " .. M.font_style .. " " .. M.font_size

-- | Taglist | --
M.taglist_spacing = dpi(1)
-- M.taglist_shape_border_width = dpi(1)
-- M.taglist_shape_border_color = M.colors.text
-- M.taglist_shape = function(cr, width, height)
--   gears.shape.rectangle(cr, width, height)
-- end

-- | Border | --
M.border_width = dpi(1)
M.border_normal = M.colors.base
M.border_focus = M.colors.mauve
M.border_marked = M.colors.mauve

-- | Menu | --
M.awesome_icon = "/usr/share/void-artwork/splash.png"
M.menu_submenu_icon = M.default_path .. "default/submenu.png"

-- | Titlebar | --
M.titlebar_close_button_normal = M.default_path
  .. "default/titlebar/close_normal.png"
M.titlebar_close_button_focus = M.default_path
  .. "default/titlebar/close_focus.png"
M.titlebar_minimize_button_normal = M.default_path
  .. "default/titlebar/minimize_normal.png"
M.titlebar_minimize_button_focus = M.default_path
  .. "default/titlebar/minimize_focus.png"
-- M.titlebar_ontop_button_normal_inactive = M.default_path
--   .. "default/titlebar/ontop_normal_inactive.png"
-- M.titlebar_ontop_button_focus_inactive = M.default_path
--   .. "default/titlebar/ontop_focus_inactive.png"
-- M.titlebar_ontop_button_normal_active = M.default_path
--   .. "default/titlebar/ontop_normal_active.png"
-- M.titlebar_ontop_button_focus_active = M.default_path
--   .. "default/titlebar/ontop_focus_active.png"
-- M.titlebar_sticky_button_normal_inactive = M.default_path
--   .. "default/titlebar/sticky_normal_inactive.png"
-- M.titlebar_sticky_button_focus_inactive = M.default_path
--   .. "default/titlebar/sticky_focus_inactive.png"
-- M.titlebar_sticky_button_normal_active = M.default_path
--   .. "default/titlebar/sticky_normal_active.png"
-- M.titlebar_sticky_button_focus_active = M.default_path
--   .. "default/titlebar/sticky_focus_active.png"
-- M.titlebar_floating_button_normal_inactive = M.default_path
--   .. "default/titlebar/floating_normal_inactive.png"
-- M.titlebar_floating_button_focus_inactive = M.default_path
--   .. "default/titlebar/floating_focus_inactive.png"
-- M.titlebar_floating_button_normal_active = M.default_path
--   .. "default/titlebar/floating_normal_active.png"
-- M.titlebar_floating_button_focus_active = M.default_path
--   .. "default/titlebar/floating_focus_active.png"
M.titlebar_maximized_button_normal_inactive = M.default_path
  .. "default/titlebar/maximized_normal_inactive.png"
M.titlebar_maximized_button_focus_inactive = M.default_path
  .. "default/titlebar/maximized_focus_inactive.png"
M.titlebar_maximized_button_normal_active = M.default_path
  .. "default/titlebar/maximized_normal_active.png"
M.titlebar_maximized_button_focus_active = M.default_path
  .. "default/titlebar/maximized_focus_active.png"

-- | Layout Box | --
M.layout_fairh = M.default_path .. "default/layouts/fairhw.png"
M.layout_fairv = M.default_path .. "default/layouts/fairvw.png"
M.layout_floating = M.default_path .. "default/layouts/floatingw.png"
M.layout_magnifier = M.default_path .. "default/layouts/magnifierw.png"
M.layout_max = M.default_path .. "default/layouts/maxw.png"
M.layout_fullscreen = M.default_path .. "default/layouts/fullscreenw.png"
M.layout_tilebottom = M.default_path .. "default/layouts/tilebottomw.png"
M.layout_tileleft = M.default_path .. "default/layouts/tileleftw.png"
M.layout_tile = M.default_path .. "default/layouts/tilew.png"
M.layout_tiletop = M.default_path .. "default/layouts/tiletopw.png"
M.layout_spiral = M.default_path .. "default/layouts/spiralw.png"
M.layout_dwindle = M.default_path .. "default/layouts/dwindlew.png"
M.layout_cornernw = M.default_path .. "default/layouts/cornernww.png"
M.layout_cornerne = M.default_path .. "default/layouts/cornernew.png"
M.layout_cornersw = M.default_path .. "default/layouts/cornersww.png"
M.layout_cornerse = M.default_path .. "default/layouts/cornersew.png"

-- | Wibar | --
M.fg_normal = M.colors.text
M.fg_focus = M.colors.mauve
M.fg_urgent = M.colors.text
M.bg_normal = M.colors.crust
M.bg_focus = M.colors.crust
M.bg_urgent = M.colors.red

-- | Tasklist Widget | --
M.tasklist_align = "center"
M.tasklist_disable_task_name = true
M.tasklist_plain_task_name = true
M.tasklist_bg_normal = M.colors.crust
M.tasklist_bg_focus = M.colors.base
M.tasklist_bg_urgent = M.colors.red
M.tasklist_fg_normal = M.colors.text
M.tasklist_fg_focus = M.colors.text
M.tasklist_fg_urgent = M.colors.text

-- | Systray Widget | --
M.systray_icon_spacing = dpi(8)

-- | Titlebar Widget | --
M.titlebar_bg_focus = M.bg_focus
M.titlebar_bg_normal = M.bg_normal
M.titlebar_fg_focus = M.fg_focus

-- | Menu Widget | --
M.menu_height = dpi(28)
M.menu_width = dpi(180)
M.menu_bg_normal = M.colors.base .. "66"
M.menu_bg_focus = M.colors.base .. "bb"

return M

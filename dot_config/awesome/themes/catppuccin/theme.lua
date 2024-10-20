-- Catppuccin Theme for AwesomeWM

local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

-- [ Icons ] --
awesome.set_preferred_icon_size(16)
M.icon_theme = "Kitty"

-- [ Path ] --
M.default_path = gears.filesystem.get_themes_dir()
M.path = gears.filesystem.get_configuration_dir() .. "/themes/catppuccin"
M.icons_path = M.path .. "/icons"

-- [ Colors ] --
M.flavour = "mocha"
M.colors = require("themes.catppuccin.flavours." .. M.flavour)
M.fg_normal = M.colors.text
M.fg_focus = M.colors.mauve
M.fg_urgent = M.colors.red
M.bg_normal = M.colors.crust
M.bg_focus = M.colors.base
M.bg_urgent = M.colors.red

M.useless_gap = 0
M.wallpaper = M.path .. "/mountains.png"

-- [ Font ] --
M.font_name = "IosevkaCapy Nerd Font"
M.font_style = "SemiBold"
M.font_size = 11
M.font = M.font_name .. " " .. M.font_style .. " " .. M.font_size

-- [ Taglist ] --
M.taglist_spacing = dpi(1)
-- M.taglist_shape_border_width = dpi(1)
-- M.taglist_shape_border_color = M.colors.text
-- M.taglist_shape = function(cr, width, height)
--   gears.shape.rectangle(cr, width, height)
-- end

-- [ Border ] --
M.border_width = dpi(1)
M.border_normal = M.colors.base
M.border_focus = M.colors.overlay0
M.border_marked = M.colors.red

-- [ Menu ] --
M.awesome_icon = M.path .. "/icons/void-logo-notext.svg"
M.menu_submenu_icon = M.default_path .. "default/submenu.png"
M.menu_height = dpi(24)
M.menu_width = dpi(125)
M.menu_bg_normal = M.colors.crust
M.menu_bg_focus = M.colors.base


-- [ Layout ] --

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

-- [ Tasklist ] --

-- Colors
M.tasklist_fg_normal = M.colors.text
M.tasklist_fg_focus = M.colors.mauve
M.tasklist_fg_urgent = M.colors.red
M.tasklist_fg_minimize = M.colors.subtext0
M.tasklist_bg_normal = M.colors.crust
M.tasklist_bg_focus = M.colors.mauve
M.tasklist_bg_urgent = M.colors.red
M.tasklist_bg_minimize = M.colors.blue

-- [ Systray Widget ] --
M.systray_icon_spacing = dpi(8)

-- Default variables
-- M.useless_gap = nil
-- M.font = nil
-- M.bg_normal = nil
-- M.bg_focus = nil
-- M.bg_urgent = nil
-- M.bg_minimize = nil
-- M.fg_normal = nil
-- M.fg_focus = nil
-- M.fg_urgent = nil
-- M.fg_minimize = nil
-- M.wallpaper = nil
-- M.bg_systray = nil
-- M.border_color_marked = nil
-- M.border_color_floating = nil
-- M.border_color_maximized = nil
-- M.border_color_fullscreen = nil
-- M.border_color_active = nil
-- M.border_color_normal = nil
-- M.border_color_urgent = nil
-- M.border_color_new = nil
-- M.border_color_floating_active = nil
-- M.border_color_floating_normal = nil
-- M.border_color_floating_urgent = nil
-- M.border_color_floating_new = nil
-- M.border_color_maximized_active = nil
-- M.border_color_maximized_normal = nil
-- M.border_color_maximized_urgent = nil
-- M.border_color_maximized_new = nil
-- M.border_color_fullscreen_active = nil
-- M.border_color_fullscreen_normal = nil
-- M.border_color_fullscreen_urgent = nil
-- M.border_color_fullscreen_new = nil
-- M.border_width = nil
-- M.border_width_floating = nil
-- M.border_width_maximized = nil
-- M.border_width_normal = nil
-- M.border_width_active = nil
-- M.border_width_urgent = nil
-- M.border_width_new = nil
-- M.border_width_floating_normal = nil
-- M.border_width_floating_active = nil
-- M.border_width_floating_urgent = nil
-- M.border_width_floating_new = nil
-- M.border_width_maximized_normal = nil
-- M.border_width_maximized_active = nil
-- M.border_width_maximized_urgent = nil
-- M.border_width_maximized_new = nil
-- M.border_width_fullscreen_normal = nil
-- M.border_width_fullscreen_active = nil
-- M.border_width_fullscreen_urgent = nil
-- M.border_width_fullscreen_new = nil
-- M.border_width_fullscreen = nil

-- arcchart
-- M.arcchart_border_color = nil
-- M.arcchart_color = nil
-- M.arcchart_border_width = nil
-- M.arcchart_paddings = nil
-- M.arcchart_thickness = nil
-- M.arcchart_rounded_edge = nil
-- M.arcchart_bg = nil
-- M.arcchart_start_angle = nil

-- awesome
-- M.awesome_icon = nil

-- calendar
-- M.calendar_style = nil
-- M.calendar_font = nil
-- M.calendar_spacing = nil
-- M.calendar_week_numbers = nil
-- M.calendar_start_sunday = nil
-- M.calendar_long_weekdays = nil
-- M.calendar_empty_color = nil

-- checkbox
-- M.checkbox_border_width = nil
-- M.checkbox_bg = nil
-- M.checkbox_border_color = nil
-- M.checkbox_check_border_color = nil
-- M.checkbox_check_border_width = nil
-- M.checkbox_check_color = nil
-- M.checkbox_shape = nil
-- M.checkbox_check_shape = nil
-- M.checkbox_paddings = nil
-- M.checkbox_color = nil

-- column
-- M.column_count = nil

-- cursor
-- M.cursor_mouse_resize = nil
-- M.cursor_mouse_move = nil

-- enable
-- M.enable_spawn_cursor = nil

-- flex
-- M.flex_height = nil

-- fullscreen
M.fullscreen_hide_border = true

-- gap
M.gap_single_client = true

-- graph
-- M.graph_fg = nil
-- M.graph_bg = nil
-- M.graph_border_color = nil

-- hotkeys
-- M.hotkeys_bg = nil
-- M.hotkeys_fg = nil
-- M.hotkeys_border_width = nil
-- M.hotkeys_border_color = nil
-- M.hotkeys_shape = nil
-- M.hotkeys_modifiers_fg = nil
-- M.hotkeys_label_bg = nil
-- M.hotkeys_label_fg = nil
-- M.hotkeys_font = nil
-- M.hotkeys_description_font = nil
-- M.hotkeys_group_margin = nil

-- icon
-- M.icon_M = nil

-- layoutlist
-- M.layoutlist_fg_normal = nil
-- M.layoutlist_bg_normal = nil
-- M.layoutlist_fg_selected = nil
-- M.layoutlist_bg_selected = nil
-- M.layoutlist_disable_icon = nil
-- M.layoutlist_disable_name = nil
-- M.layoutlist_font = nil
-- M.layoutlist_align = nil
-- M.layoutlist_font_selected = nil
-- M.layoutlist_spacing = nil
-- M.layoutlist_shape = nil
-- M.layoutlist_shape_border_width = nil
-- M.layoutlist_shape_border_color = nil
-- M.layoutlist_shape_selected = nil
-- M.layoutlist_shape_border_width_selected = nil
-- M.layoutlist_shape_border_color_selected = nil

-- master
-- M.master_width_factor = nil
-- M.master_fill_policy = nil
-- M.master_count = nil

-- maximized
-- M.maximized_honor_padding = nil
M.maximized_hide_border = true

-- menu
-- M.menu_submenu_icon = nil
-- M.menu_font = nil
-- M.menu_height = nil
-- M.menu_width = nil
-- M.menu_border_color = nil
-- M.menu_border_width = nil
-- M.menu_fg_focus = nil
-- M.menu_bg_focus = nil
-- M.menu_fg_normal = nil
-- M.menu_bg_normal = nil
-- M.menu_submenu = nil

-- menubar
-- M.menubar_fg_normal = nil
-- M.menubar_bg_normal = nil
-- M.menubar_border_width = nil
-- M.menubar_border_color = nil
-- M.menubar_fg_focus = nil
-- M.menubar_bg_focus = nil
-- M.menubar_font = nil

-- notification
-- M.notification_max_width = nil
-- M.notification_position = nil
-- M.notification_action_underline_normal = nil
-- M.notification_action_underline_selected = nil
-- M.notification_action_icon_only = nil
-- M.notification_action_label_only = nil
-- M.notification_action_shape_normal = nil
-- M.notification_action_shape_selected = nil
-- M.notification_action_shape_border_color_normal = nil
-- M.notification_action_shape_border_color_selected = nil
-- M.notification_action_shape_border_width_normal = nil
-- M.notification_action_shape_border_width_selected = nil
-- M.notification_action_icon_size_normal = nil
-- M.notification_action_icon_size_selected = nil
-- M.notification_action_bg_normal = nil
-- M.notification_action_bg_selected = nil
-- M.notification_action_fg_normal = nil
-- M.notification_action_fg_selected = nil
-- M.notification_action_bgimage_normal = nil
-- M.notification_action_bgimage_selected = nil
-- M.notification_shape_normal = nil
-- M.notification_shape_selected = nil
-- M.notification_shape_border_color_normal = nil
-- M.notification_shape_border_color_selected = nil
-- M.notification_shape_border_width_normal = nil
-- M.notification_shape_border_width_selected = nil
-- M.notification_icon_size_normal = nil
-- M.notification_icon_size_selected = nil
M.notification_bg_normal = M.bg_normal
-- M.notification_bg_selected = nil
M.notification_fg_normal = M.fg_normal
-- M.notification_fg_selected = nil
-- M.notification_bgimage_normal = nil
-- M.notification_bgimage_selected = nil
-- M.notification_font = nil
-- M.notification_bg = nil
-- M.notification_fg = nil
M.notification_border_width = M.border_width
M.notification_border_color = M.colors.text
-- M.notification_shape = nil
M.notification_opacity = 0.5
-- M.notification_margin = nil
-- M.notification_width = nil
-- M.notification_height = nil
-- M.notification_spacing = nil
-- M.notification_icon_resize_strategy = nil
-- M.notification_icon_size = nil

-- opacity
-- M.opacity_normal = nil
-- M.opacity_active = nil
-- M.opacity_urgent = nil
-- M.opacity_new = nil
-- M.opacity_floating_normal = nil
-- M.opacity_floating_active = nil
-- M.opacity_floating_urgent = nil
-- M.opacity_floating_new = nil
-- M.opacity_floating = nil
-- M.opacity_maximized_normal = nil
-- M.opacity_maximized_active = nil
-- M.opacity_maximized_urgent = nil
-- M.opacity_maximized_new = nil
-- M.opacity_maximized = nil
-- M.opacity_fullscreen_normal = nil
-- M.opacity_fullscreen_active = nil
-- M.opacity_fullscreen_urgent = nil
-- M.opacity_fullscreen_new = nil
-- M.opacity_fullscreen = nil

-- piechart
-- M.piechart_border_color = nil
-- M.piechart_border_width = nil
-- M.piechart_colors = nil

-- progressbar
-- M.progressbar_bg = nil
-- M.progressbar_fg = nil
-- M.progressbar_shape = nil
-- M.progressbar_border_color = nil
-- M.progressbar_border_width = nil
-- M.progressbar_bar_shape = nil
-- M.progressbar_bar_border_width = nil
-- M.progressbar_bar_border_color = nil
-- M.progressbar_margins = nil
-- M.progressbar_paddings = nil

-- prompt
-- M.prompt_fg_cursor = nil
-- M.prompt_bg_cursor = nil
-- M.prompt_font = nil
-- M.prompt_fg = nil
-- M.prompt_bg = nil

-- radialprogressbar
-- M.radialprogressbar_border_color = nil
-- M.radialprogressbar_color = nil
-- M.radialprogressbar_border_width = nil
-- M.radialprogressbar_paddings = nil

-- screenshot
-- M.screenshot_frame_color = nil
-- M.screenshot_frame_shape = nil

-- separator
-- M.separator_thickness = nil
-- M.separator_border_color = nil
-- M.separator_border_width = nil
-- M.separator_span_ratio = nil
-- M.separator_color = nil
-- M.separator_shape = nil

-- slider
-- M.slider_bar_border_width = nil
-- M.slider_bar_border_color = nil
-- M.slider_handle_border_color = nil
-- M.slider_handle_border_width = nil
-- M.slider_handle_width = nil
-- M.slider_handle_color = nil
-- M.slider_handle_shape = nil
-- M.slider_handle_cursor = nil
-- M.slider_bar_shape = nil
-- M.slider_bar_height = nil
-- M.slider_bar_margins = nil
-- M.slider_handle_margins = nil
-- M.slider_bar_color = nil
-- M.slider_bar_active_color = nil

-- snap
-- M.snap_bg = nil
-- M.snap_border_width = nil
-- M.snap_shape = nil

-- snapper
-- M.snapper_gap = nil

-- systray
-- M.systray_max_rows = nil
-- M.systray_icon_spacing = nil

-- taglist
-- M.taglist_fg_focus = nil
-- M.taglist_bg_focus = nil
-- M.taglist_fg_urgent = nil
-- M.taglist_bg_urgent = nil
-- M.taglist_bg_occupied = nil
-- M.taglist_fg_occupied = nil
-- M.taglist_bg_empty = nil
-- M.taglist_fg_empty = nil
-- M.taglist_bg_volatile = nil
-- M.taglist_fg_volatile = nil
-- M.taglist_squares_sel = nil
-- M.taglist_squares_unsel = nil
-- M.taglist_squares_sel_empty = nil
-- M.taglist_squares_unsel_empty = nil
-- M.taglist_squares_resize = nil
-- M.taglist_disable_icon = nil
-- M.taglist_font = nil
-- M.taglist_spacing = nil
-- M.taglist_shape = nil
-- M.taglist_shape_border_width = nil
-- M.taglist_shape_border_color = nil
-- M.taglist_shape_empty = nil
-- M.taglist_shape_border_width_empty = nil
-- M.taglist_shape_border_color_empty = nil
-- M.taglist_shape_focus = nil
-- M.taglist_shape_border_width_focus = nil
-- M.taglist_shape_border_color_focus = nil
-- M.taglist_shape_urgent = nil
-- M.taglist_shape_border_width_urgent = nil
-- M.taglist_shape_border_color_urgent = nil
-- M.taglist_shape_volatile = nil
-- M.taglist_shape_border_width_volatile = nil
-- M.taglist_shape_border_color_volatile = nil

-- tooltip
-- M.tooltip_border_color = nil
-- M.tooltip_bg = nil
-- M.tooltip_fg = nil
-- M.tooltip_font = nil
-- M.tooltip_border_width = nil
-- M.tooltip_opacity = nil
-- M.tooltip_gaps = nil
-- M.tooltip_shape = nil
-- M.tooltip_align = nil

-- wallpaper
-- M.wallpaper_bg = nil
-- M.wallpaper_fg = nil

return M

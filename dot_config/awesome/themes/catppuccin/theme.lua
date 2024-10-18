-- Catppuccin Theme for AwesomeWM

local gears = require("gears")
local dpi = require("beautiful.xresources").apply_dpi

local M = {}

-- | Icons | --
awesome.set_preferred_icon_size(16)
M.icon_theme = "Kitty"

-- | Path | --
M.default_path = gears.filesystem.get_themes_dir()
M.path = gears.filesystem.get_configuration_dir() .. "/themes/catppuccin"

-- | Colors | --
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

-- | Font | --
M.font_name = "IosevkaCapy Nerd Font"
M.font_style = "SemiBold"
M.font_size = 11
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
M.border_focus = M.colors.overlay0
M.border_marked = M.colors.red

-- | Menu | --
M.awesome_icon = "/usr/share/awesome/icons/awesome16.png"
M.menu_submenu_icon = M.default_path .. "default/submenu.png"
M.menu_height = dpi(24)
M.menu_width = dpi(125)
M.menu_bg_normal = M.colors.crust
M.menu_bg_focus = M.colors.base

-- | Titlebar | --
M.titlebar_close_button_normal = M.default_path
    .. "default/titlebar/close_normal.png"
M.titlebar_close_button_focus = M.default_path
    .. "default/titlebar/close_focus.png"
M.titlebar_minimize_button_normal = M.default_path
    .. "default/titlebar/minimize_normal.png"
M.titlebar_minimize_button_focus = M.default_path
    .. "default/titlebar/minimize_focus.png"
M.titlebar_maximized_button_normal_inactive = M.default_path
    .. "default/titlebar/maximized_normal_inactive.png"
M.titlebar_maximized_button_focus_inactive = M.default_path
    .. "default/titlebar/maximized_focus_inactive.png"
M.titlebar_maximized_button_normal_active = M.default_path
    .. "default/titlebar/maximized_normal_active.png"
M.titlebar_maximized_button_focus_active = M.default_path
    .. "default/titlebar/maximized_focus_active.png"

-- layout
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

-- tasklist
M.tasklist_fg_normal = M.fg_normal
M.tasklist_fg_focus = M.fg_focus
M.tasklist_fg_urgent = M.fg_urgent
M.tasklist_bg_normal = M.bg_normal
M.tasklist_bg_focus = M.colors.mauve
M.tasklist_bg_urgent = M.bg_urgent
-- M.tasklist_fg_minimize = nil
-- M.tasklist_bg_minimize = nil
-- M.tasklist_bg_image_normal = nil
-- M.tasklist_bg_image_focus = nil
-- M.tasklist_bg_image_urgent = nil
-- M.tasklist_bg_image_minimize = nil
-- M.tasklist_disable_icon = nil
-- M.tasklist_disable_task_name = nil
-- M.tasklist_plain_task_name = nil
-- M.tasklist_sticky = nil
-- M.tasklist_ontop = nil
-- M.tasklist_above = nil
-- M.tasklist_below = nil
-- M.tasklist_floating = nil
-- M.tasklist_maximized = nil
-- M.tasklist_maximized_horizontal = nil
-- M.tasklist_maximized_vertical = nil
-- M.tasklist_minimized = nil
-- M.tasklist_align = nil
-- M.tasklist_font = nil
-- M.tasklist_font_focus = nil
-- M.tasklist_font_minimized = nil
-- M.tasklist_font_urgent = nil
-- M.tasklist_spacing = nil
-- M.tasklist_shape = nil
-- M.tasklist_shape_border_width = nil
-- M.tasklist_shape_border_color = nil
-- M.tasklist_shape_focus = nil
-- M.tasklist_shape_border_width_focus = nil
-- M.tasklist_shape_border_color_focus = nil
-- M.tasklist_shape_minimized = nil
-- M.tasklist_shape_border_width_minimized = nil
-- M.tasklist_shape_border_color_minimized = nil
-- M.tasklist_shape_urgent = nil
-- M.tasklist_shape_border_width_urgent = nil
-- M.tasklist_shape_border_color_urgent = nil
-- M.tasklist_icon_size = nil

-- | Systray Widget | --
M.systray_icon_spacing = dpi(8)

-- | Titlebar Widget | --
M.titlebar_bg_focus = M.bg_focus
M.titlebar_bg_normal = M.bg_normal
M.titlebar_fg_focus = M.fg_focus

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

-- titlebar
-- M.titlebar_fg_normal = nil
-- M.titlebar_bg_normal = nil
-- M.titlebar_bgimage_normal = nil
-- M.titlebar_fg = nil
-- M.titlebar_bg = nil
-- M.titlebar_bgimage = nil
-- M.titlebar_fg_focus = nil
-- M.titlebar_bg_focus = nil
-- M.titlebar_bgimage_focus = nil
-- M.titlebar_fg_urgent = nil
-- M.titlebar_bg_urgent = nil
-- M.titlebar_bgimage_urgent = nil
-- M.titlebar_floating_button_normal = nil
-- M.titlebar_maximized_button_normal = nil
-- M.titlebar_minimize_button_normal = nil
-- M.titlebar_minimize_button_normal_hover = nil
-- M.titlebar_minimize_button_normal_press = nil
-- M.titlebar_close_button_normal = nil
-- M.titlebar_close_button_normal_hover = nil
-- M.titlebar_close_button_normal_press = nil
-- M.titlebar_ontop_button_normal = nil
-- M.titlebar_sticky_button_normal = nil
-- M.titlebar_floating_button_focus = nil
-- M.titlebar_maximized_button_focus = nil
-- M.titlebar_minimize_button_focus = nil
-- M.titlebar_minimize_button_focus_hover = nil
-- M.titlebar_minimize_button_focus_press = nil
-- M.titlebar_close_button_focus = nil
-- M.titlebar_close_button_focus_hover = nil
-- M.titlebar_close_button_focus_press = nil
-- M.titlebar_ontop_button_focus = nil
-- M.titlebar_sticky_button_focus = nil
-- M.titlebar_floating_button_normal_active = nil
-- M.titlebar_floating_button_normal_active_hover = nil
-- M.titlebar_floating_button_normal_active_press = nil
-- M.titlebar_maximized_button_normal_active = nil
-- M.titlebar_maximized_button_normal_active_hover = nil
-- M.titlebar_maximized_button_normal_active_press = nil
-- M.titlebar_ontop_button_normal_active = nil
-- M.titlebar_ontop_button_normal_active_hover = nil
-- M.titlebar_ontop_button_normal_active_press = nil
-- M.titlebar_sticky_button_normal_active = nil
-- M.titlebar_sticky_button_normal_active_hover = nil
-- M.titlebar_sticky_button_normal_active_press = nil
-- M.titlebar_floating_button_focus_active = nil
-- M.titlebar_floating_button_focus_active_hover = nil
-- M.titlebar_floating_button_focus_active_press = nil
-- M.titlebar_maximized_button_focus_active = nil
-- M.titlebar_maximized_button_focus_active_hover = nil
-- M.titlebar_maximized_button_focus_active_press = nil
-- M.titlebar_ontop_button_focus_active = nil
-- M.titlebar_ontop_button_focus_active_hover = nil
-- M.titlebar_ontop_button_focus_active_press = nil
-- M.titlebar_sticky_button_focus_active = nil
-- M.titlebar_sticky_button_focus_active_hover = nil
-- M.titlebar_sticky_button_focus_active_press = nil
-- M.titlebar_floating_button_normal_inactive = nil
-- M.titlebar_floating_button_normal_inactive_hover = nil
-- M.titlebar_floating_button_normal_inactive_press = nil
-- M.titlebar_maximized_button_normal_inactive = nil
-- M.titlebar_maximized_button_normal_inactive_hover = nil
-- M.titlebar_maximized_button_normal_inactive_press = nil
-- M.titlebar_ontop_button_normal_inactive = nil
-- M.titlebar_ontop_button_normal_inactive_hover = nil
-- M.titlebar_ontop_button_normal_inactive_press = nil
-- M.titlebar_sticky_button_normal_inactive = nil
-- M.titlebar_sticky_button_normal_inactive_hover = nil
-- M.titlebar_sticky_button_normal_inactive_press = nil
-- M.titlebar_floating_button_focus_inactive = nil
-- M.titlebar_floating_button_focus_inactive_hover = nil
-- M.titlebar_floating_button_focus_inactive_press = nil
-- M.titlebar_maximized_button_focus_inactive = nil
-- M.titlebar_maximized_button_focus_inactive_hover = nil
-- M.titlebar_maximized_button_focus_inactive_press = nil
-- M.titlebar_ontop_button_focus_inactive = nil
-- M.titlebar_ontop_button_focus_inactive_hover = nil
-- M.titlebar_ontop_button_focus_inactive_press = nil
-- M.titlebar_sticky_button_focus_inactive = nil
-- M.titlebar_sticky_button_focus_inactive_hover = nil
-- M.titlebar_sticky_button_focus_inactive_press = nil
-- M.titlebar_tooltip_messages_close = nil
-- M.titlebar_tooltip_messages_minimize = nil
-- M.titlebar_tooltip_messages_maximized_active = nil
-- M.titlebar_tooltip_messages_maximized_inactive = nil
-- M.titlebar_tooltip_messages_floating_active = nil
-- M.titlebar_tooltip_messages_floating_inactive = nil
-- M.titlebar_tooltip_messages_ontop_active = nil
-- M.titlebar_tooltip_messages_ontop_inactive = nil
-- M.titlebar_tooltip_messages_sticky_active = nil
-- M.titlebar_tooltip_messages_sticky_inactive = nil
-- M.titlebar_tooltip_delay_show = nil
-- M.titlebar_tooltip_margins_leftright = nil
-- M.titlebar_tooltip_margins_topbottom = nil
-- M.titlebar_tooltip_timeout = nil
-- M.titlebar_tooltip_align = nil

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

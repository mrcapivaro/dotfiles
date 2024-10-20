local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Colors
beautiful.titlebar_fg = beautiful.colors.text
beautiful.titlebar_bg = beautiful.colors.crust
-- beautiful.titlebar_fg_normal = beautiful.colors.text
-- beautiful.titlebar_bg_normal = beautiful.colors.crust
-- beautiful.titlebar_fg_focus = beautiful.titlebar_fg_normal
-- beautiful.titlebar_bg_focus = beautiful.titlebar_bg_normal
-- beautiful.titlebar_fg_urgent = nil
-- beautiful.titlebar_bg_urgent = nil
-- beautiful.titlebar_bgimage = nil
-- beautiful.titlebar_bgimage_normal = nil
-- beautiful.titlebar_bgimage_focus = nil
-- beautiful.titlebar_bgimage_urgent = nil

-- Icons
local title_icons = beautiful.path .. "/icons/titlebar"
-- close button
beautiful.titlebar_close_button_focus = title_icons .. "/close.svg"
beautiful.titlebar_close_button_focus_hover = title_icons .. "/close_hover.svg"
-- beautiful.titlebar_close_button_focus_press = nil
-- maximize button
beautiful.titlebar_maximized_button_focus_inactive = title_icons .. "/maximize.svg"
beautiful.titlebar_maximized_button_focus_inactive_hover = title_icons
    .. "/maximize_hover.svg"
-- beautiful.titlebar_maximized_button_focus_active = title_icons .. "/minimize.svg"
-- beautiful.titlebar_maximized_button_focus_active_hover = title_icons
--     .. "/minimize_hover.svg"
-- beautiful.titlebar_maximized_button_focus_active_press = nil
-- beautiful.titlebar_maximized_button_focus_inactive_press = nil
-- minimize button
beautiful.titlebar_minimize_button_focus = title_icons .. "/minimize.svg"
beautiful.titlebar_minimize_button_focus_hover = title_icons .. "/minimize_hover.svg"
-- beautiful.titlebar_minimize_button_focus_press = nil

-- BUG: These options are being ignored.
-- Tooltip Messages
-- beautiful.titlebar_tooltip_messages_close = nil
-- beautiful.titlebar_tooltip_messages_minimize = nil
-- beautiful.titlebar_tooltip_messages_maximized_active = nil
-- beautiful.titlebar_tooltip_messages_maximized_inactive = nil
-- beautiful.titlebar_tooltip_messages_floating_active = nil
-- beautiful.titlebar_tooltip_messages_floating_inactive = nil
-- beautiful.titlebar_tooltip_messages_ontop_active = nil
-- beautiful.titlebar_tooltip_messages_ontop_inactive = nil
-- beautiful.titlebar_tooltip_messages_sticky_active = nil
-- beautiful.titlebar_tooltip_messages_sticky_inactive = nil
-- beautiful.titlebar_tooltip_delay_show = nil
-- beautiful.titlebar_tooltip_margins_leftright = nil
-- beautiful.titlebar_tooltip_margins_topbottom = nil
-- beautiful.titlebar_tooltip_timeout = nil
-- beautiful.titlebar_tooltip_align = nil

local M = {}

M.options = {
    size = 20,
}

local mt = {}

mt.__call = function(_, c)
    local titlebar_buttons = require("binds.titlebar-buttons")(c)
    awful.titlebar(c, { size = M.options.size }):setup({
        {
            { -- Left
                -- awful.titlebar.widget.iconwidget(c),
                buttons = titlebar_buttons,
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle
                {
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c),
                },
                buttons = titlebar_buttons,
                layout = wibox.layout.flex.horizontal,
            },
            { -- Right
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal(),
            },
            layout = wibox.layout.align.horizontal,
        },
        widget = wibox.container.margin,
        margins = 2,
    })
end

setmetatable(M, mt)

return M

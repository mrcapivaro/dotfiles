local awful = require("awful")
local wibox = require("wibox")
local tasklist_buttons = require("binds.tasklist-buttons")
local dpi = require("beautiful.xresources").apply_dpi

local template = {
    {
        wibox.widget.base.make_widget(),
        forced_height = 2,
        id = "background_role",
        widget = wibox.container.background,
    },
    {
        {
            -- awful.widget.clienticon,
            id = "icon_role",
            widget = wibox.widget.imagebox,
        },
        widget = wibox.container.margin,
        margins = 1,
    },
    nil,
    layout = wibox.layout.fixed.vertical,
}

awful.screen.connect_for_each_screen(function(s)
    s.tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = dpi(8),
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = template,
    })
end)

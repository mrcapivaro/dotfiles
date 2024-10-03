local awful = require("awful")
local wibox = require("wibox")
local tasklist_buttons = require("binds.tasklist-buttons")
local dpi = require("beautiful.xresources").apply_dpi

local template = {
    {
        {
            {
                id = "icon_role",
                widget = wibox.widget.imagebox,
            },
            margins = 3,
            widget = wibox.container.margin,
        },
        id = "background_role",
        widget = wibox.container.background,
    },
    layout = wibox.layout.stack,
}

awful.screen.connect_for_each_screen(function(s)
    s.tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = dpi(2),
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = template,
    })
end)

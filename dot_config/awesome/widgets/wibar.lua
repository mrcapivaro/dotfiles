local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local date = require("widgets.date")
local time = require("widgets.time")
local keyboardlayout = require("widgets.keyboardlayout")
local systray = require("widgets.systray")
local launcher = require("widgets.launcher")

require("widgets.tasklist")
require("widgets.taglist")
require("widgets.layoutbox")

beautiful.wibar_height = 24

awful.screen.connect_for_each_screen(function(s)
    s.wibar = awful.wibar({ position = "top", screen = s })
    s.wibar:setup({
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            s.layoutbox,
            s.taglist,
        },
        {
            {
                layout = wibox.layout.fixed.horizontal,
                launcher,
                s.tasklist,
            },
            widget = wibox.container.place,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            keyboardlayout,
            {
                systray,
                widget = wibox.container.place,
                -- valign = "bottom",
                -- halign = "left",
            },
            date,
            time,
        },
    })
end)

local awful = require("awful")
local wibox = require("wibox")

local textclock = require("widgets.textclock")
local keyboardlayout = require("widgets.keyboardlayout")
local systray = require("widgets.systray")

require("widgets.tasklist")
require("widgets.taglist")
require("widgets.layoutbox")

local beautiful = require("beautiful")
beautiful.wibar_height = 30

awful.screen.connect_for_each_screen(function(s)
    s.mywibar = awful.wibar({ position = "top", screen = s })
    s.mywibar:setup({
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            {
                s.layoutbox,
                widget = wibox.container.margin,
                margins = 4,
            },
            s.taglist,
        },
        {
            s.tasklist,
            widget = wibox.container.place,
        },
        {
            layout = wibox.layout.fixed.horizontal,
            {
                systray,
                widget = wibox.container.place,
                valign = "bottom",
            },
            {
                keyboardlayout,
                widget = wibox.container.margin,
                left = 15,
            },
            textclock,
        },
    })
end)

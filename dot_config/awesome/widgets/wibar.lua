local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local date = require("widgets.date")
local time = require("widgets.time")
local keyboardlayout = require("widgets.keyboardlayout")
local systray = require("widgets.systray")
local launcher = require("widgets.launcher")

local tasklist = require("widgets.tasklist")
require("widgets.taglist")
require("widgets.layoutbox")

local M = {}

M.options = {
    size = 24,
    spacing = 8,
    margins = 4,
    position = "top",
}

M.widget_template = {

}

local mt = {}

mt.__call = function(_)
    beautiful.wibar_height = M.options.size
    awful.screen.connect_for_each_screen(function(s)
        s.tasklist = tasklist(s)
        s.wibar = awful.wibar({ position = M.options.position, screen = s })
        s.wibar:setup({
            {
                layout = wibox.layout.align.horizontal,
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = M.options.spacing,
                    launcher,
                    s.taglist,
                    s.layoutbox,
                },
                {
                    s.tasklist,
                    widget = wibox.container.place,
                },
                {
                    layout = wibox.layout.fixed.horizontal,
                    spacing = M.options.spacing,
                    keyboardlayout,
                    {
                        systray,
                        widget = wibox.container.place,
                        valign = "bottom",
                        -- halign = "left",
                    },
                    date,
                    time,
                },
            },
            widget = wibox.container.margin,
            margins = M.options.margins,
        })
    end)
end

setmetatable(M, mt)

return M

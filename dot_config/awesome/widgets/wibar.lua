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
    height = 24,
    spacing = 8,
    margins = 4,
    position = "top",
}

M.widget_template = {}

local mt = {}

mt.__call = function(_, args)
    beautiful.wibar_height =  M.options.height
    -- beautiful.wibar_stretch = args.stretch
    -- beautiful.wibar_favor_vertical = args.favor_vertical
    -- beautiful.wibar_border_width = args.border_width
    -- beautiful.wibar_border_color = args.border_color
    -- beautiful.wibar_ontop = args.ontop
    -- beautiful.wibar_cursor = args.cursor
    -- beautiful.wibar_opacity = args.opacity
    -- beautiful.wibar_type = args.type
    -- beautiful.wibar_width = args.width
    -- beautiful.wibar_bg = args.bg
    -- beautiful.wibar_bgimage = args.bgimage
    -- beautiful.wibar_fg = args.fg
    -- beautiful.wibar_shape = args.shape
    -- beautiful.wibar_margins = args.margins
    -- beautiful.wibar_align = args.align
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

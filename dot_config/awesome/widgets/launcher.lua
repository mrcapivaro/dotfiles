local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

local os_menu = awful.menu({
    items = {
        {
            "󰐥  poweroff",
            function()
                awesome.spawn("loginctl poweroff")
            end,
        },
        {
            "󰑓  reboot",
            function()
                awesome.spawn("loginctl reboot")
            end,
        },
        {
            "󰤄  sleep",
            function()
                awesome.spawn("loginctl hybrid-sleep")
            end,
        },
        {
            "  logoff",
            awesome.quit,
        },
    },
})

local M = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = os_menu,
})

return M

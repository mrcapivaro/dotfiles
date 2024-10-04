local awful = require("awful")
local beautiful = require("beautiful")

local clientbuttons = require("binds.client-buttons")
local clientkeys = require("binds.client-keys")

awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap
                + awful.placement.no_offscreen,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",
                "copyq",
                "pinentry",
            },
            class = {
                "steam",
                "Spotify",
                "vesktop",
            },
            name = {
                "Event Tester", -- xev.
                "spotify",
            },
            role = {
                "AlarmWindow",
                "ConfigManager",
                "pop-up",
            },
        },
        properties = {
            floating = true,
            titlebars_enabled = true,
        },
    },
}

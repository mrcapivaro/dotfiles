local awful = require("awful")
local beautiful = require("beautiful")

local client_buttons = require("binds.client-buttons")
local client_keys = require("binds.client-keys")

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap
                + awful.placement.no_offscreen,
            titlebars_enabled = false,
            floating = false,
        },
    },

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
                "Event Tester",
                "spotify",
            },
            role = {
                "AlarmWindow",
                "ConfigManager",
            },
            type = { "dialog" },
        },
        properties = {
            floating = true,
            titlebars_enabled = true,
            placement = awful.placement.centered,
        },
    },

    {
        rule_any = {
            role = {
                "pop-up",
                "Pop-up",
                "popup",
                "Popup",
            },
        },
        properties = {
            floating = true,
            titlebars_enabled = false,
            placement = awful.placement.centered,
        },
    },
}

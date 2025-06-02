local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

local poppin = require("modules.poppin")

-- Client Keybinds and Buttons {{{1

local modkey = "Mod4"

local client_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

local client_keys = gears.table.join(
    awful.key({ modkey, "Shift" }, "m", function(c)
        awful.client.setmaster(c)
    end, { description = "set master", group = "client" }),

    awful.key({ modkey, "Control" }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),

    awful.key({ "Mod1" }, "F4", function(c)
        c:kill()
    end, { description = "close client", group = "client" }),

    awful.key({ modkey }, "c", function(c)
        c:kill()
    end, { description = "close client", group = "client" }),

    awful.key(
        { modkey },
        "v",
        awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }
    ),

    awful.key({ modkey }, "t", function(c)
        c.ontop = not c.ontop
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, "Control" }, "t", function(c)
        c.titlebars_enabled = not c.titlebars_enabled
        awful.titlebar.toggle(c)
    end, { description = "toggle titlebars", group = "client" }),

    awful.key({ modkey }, "z", function(c)
        c.minimized = true
    end, { description = "minimize", group = "client" }),

    awful.key({ modkey }, "f", function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = "toggle maximize", group = "client" })
)

-- 1}}}
-- Client Rules {{{1

awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width_normal,
            border_color = beautiful.border_color_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered,
            floating = true,
        },
    },

    -- Always maximize
    {
        rule_any = {
            class = {
                "obsidian",
            },
        },
        properties = {
            maximized = true,
            floating = false,
            placement = awful.placement.centered,
        },
    },

    -- Always tile
    {
        rule_any = {
            class = {
                "Emacs",
                "Alacritty",
                "ghostty",
                "alacritty",
                "wezterm",
                "kitty",
                "Firefox",
                "Navigator",
            },
        },
        properties = {
            floating = false,
            placement = awful.placement.no_overlap
                + awful.placement.no_offscreen,
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
            requests_no_titlebar = true,
            placement = awful.placement.centered,
        },
    },

    -- emacs not occupying all screen space in tile mode bug.
    -- source: https://superuser.com/questions/751075/emacs-maximized-but-leaves-few-pixels-in-awesome-wm
    {
        rule = { class = "Emacs" },
        properties = { size_hints_honor = false },
    },
}

-- 1}}}
-- Client Signals {{{1

-- Used to allow automatic change of focus when clients are killed or created.
require("awful.autofocus")

local user_signals = {
    -- The "manage" signal triggers when a client starts, but after the rules
    -- are applied.
    manage = function(c)
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        if not awesome.startup then
            awful.client.setslave(c)
        end

        -- Prevent clients from being unreachable after screen count changes.
        if
            awesome.startup
            and not c.size_hints.user_position
            and not c.size_hints.program_position
        then
            awful.placement.no_offscreen(c)
        end
    end,
    properties = {
        floating = function(c)
            c.titlebars_enabled = c.floating

            if c.floating then
                awful.placement.centered(c)
            end
        end,
        titlebars_enabled = function(c)
            if
                c.titlebars_enabled
                and not c.requests_no_titlebar
                and not poppin.isPoppin(c)
            then
                awful.titlebar.show(c)
            else
                awful.titlebar.hide(c)
            end
        end,
        fullscreen = function(c)
            -- Adjust the geometry of fullscreen clients to always cover the
            -- entire screen.
            gears.timer.delayed_call(function()
                if c.valid then
                    c:geometry(c.screen.geometry)
                end
            end)
        end,
    },
}

client.connect_signal("manage", user_signals.manage)
for sig_name, sig_cb in pairs(user_signals.properties) do
    client.connect_signal("property::" .. sig_name, sig_cb)
end

-- 1}}}
-- Tags Creation and Behavior {{{1

awful.layout.layouts = {
    awful.layout.suit.tile.right,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

awful.screen.connect_for_each_screen(function(s)
    -- Setup a set of tags for each screen.
    -- Symbols: ● ○ ◉
    awful.tag({ "○", "○", "○" }, s, awful.layout.layouts[1])
end)

-- Set all clients to floating when the layout changes to floating.
awful.tag.attached_connect_signal(nil, "property::layout", function(t)
    local float = t.layout.name == "floating"
    for _, c in pairs(t:clients()) do
        c.floating = float
    end
end)

-- 1}}}

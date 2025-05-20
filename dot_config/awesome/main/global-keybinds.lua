local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local poppin = require("modules.poppin")
local cyclefocus = require("modules.cyclefocus")
-- local util = require("modules.util")

local modkey = "Mod4"
local global_keybinds = {}

-- Misc {{{1

global_keybinds = gears.table.join(
    global_keybinds,

    awful.key({ modkey }, "a", function()
        poppin.pop(
            "terminal",
            "ghostty",
            "center",
            750,
            function (c)
                c.titlebars_enabled = false
            end
        )
    end, { description = "scratchpad: terminal", group = "scratchpad" }),

    awful.key({ modkey }, "r", function()
        local is_conf_valid = os.execute("awesome -k")
        if not is_conf_valid then
            naughty.notify({
                title = "Awesome WM config file has invalid syntax!",
                text = "The restart failed..."
            })
            return
        end
        awesome.restart()
    end, { description = "reload awesome", group = "awesome" }),

    awful.key(
        { modkey },
        "'",
        function()
            local current = awesome.xkb_get_layout_group()
            awesome.xkb_set_layout_group(current + 1)
        end,
        { description = "Next xkb keyboard layout.", group = "keyboard" }
    )
)

-- 1}}}
-- Print Screen {{{1

global_keybinds = gears.table.join(
    global_keybinds,

    awful.key({}, "Print", function()
        awful.spawn.with_shell("~/.config/awesome/scripts/print-screen.sh")
    end, { description = "screenshot selection", group = "screenshot" }),

    awful.key({ "Shift" }, "Print", function()
        awful.spawn.with_shell(
            "maim -m 10 -i $(xdotool getactivewindow) ~/Pictures/lsc.png"
        )
    end, {
        description = "screenshot active window",
        group = "screenshot",
    }),

    awful.key({ "Control" }, "Print", function()
        awful.spawn.with_shell("firefox ~/Pictures/lsc.png")
    end, {
        description = "Open last screenshot in image viewer.",
        group = "screenshot",
    })
)

-- 1}}}
-- Clients {{{1

global_keybinds = gears.table.join(
    global_keybinds,
    awful.key({ modkey, "Control" }, "z", function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal(
                "request::activate",
                "key.unminimize",
                { raise = true }
            )
        end
    end, { description = "restore minimized", group = "client" }),

    -- Relative client focus movement
    awful.key({ modkey }, "j", function()
        awful.client.focus.bydirection("down")
    end, {
        description = "focus client by direction: down",
        group = "client",
    }),
    awful.key({ modkey }, "k", function()
        awful.client.focus.bydirection("up")
    end, { description = "focus client by direction: up", group = "client" }),
    awful.key({ modkey }, "h", function()
        awful.client.focus.bydirection("left")
    end, {
        description = "focus client by direction: left",
        group = "client",
    }),
    awful.key({ modkey }, "l", function()
        awful.client.focus.bydirection("right")
    end, {
        description = "focus client by direction: right",
        group = "client",
    }),

    -- Client master resize
    awful.key({ modkey, "Shift" }, "h", function()
        awful.tag.incmwfact(-0.05)
    end, { description = "decrease master", group = "client" }),
    awful.key({ modkey, "Shift" }, "l", function()
        awful.tag.incmwfact(0.05)
    end, { description = "increase master", group = "client" }),

    --Relative Client Swap
    awful.key({ modkey, "Control" }, "j", function()
        awful.client.swap.bydirection("down")
    end, { description = "swap client by direction: down", group = "client" }),
    awful.key({ modkey, "Control" }, "k", function()
        awful.client.swap.bydirection("up")
    end, { description = "swap client by direction: up", group = "client" }),
    awful.key({ modkey, "Control" }, "h", function()
        awful.client.swap.bydirection("left")
    end, { description = "swap client by direction: left", group = "client" }),
    awful.key({ modkey, "Control" }, "l", function()
        awful.client.swap.bydirection("right")
    end, {
        description = "swap client by direction: right",
        group = "client",
    })
)

-- 1}}}
-- Alt + Tab {{{1

global_keybinds = gears.table.join(
    global_keybinds,
    cyclefocus.key({ "Mod1" }, "Tab", {
        cycle_filters = {},
        move_mouse_pointer = false,
        keys = { "Tab", "ISO_Left_Tab" },
    }),
    cyclefocus.key({ "Mod1", "Shift" }, "Tab", {
        cycle_filters = {},
        move_mouse_pointer = false,
        keys = { "Tab", "ISO_Left_Tab" },
    })
)

-- 1}}}
-- Rofi {{{1

global_keybinds = gears.table.join(
    global_keybinds,

    awful.key({ modkey }, "d", function()
        awful.spawn.with_shell("~/.config/rofi/launchers/apps.sh")
    end, { description = "rofi dmenu", group = "rofi" }),

    awful.key({ modkey }, "s", function()
        awful.spawn.with_shell("~/.config/rofi/launchers/files.sh")
    end, { description = "rofi file browser", group = "rofi" }),

    awful.key({ modkey }, "x", function()
        awful.spawn.with_shell("~/.config/rofi/launchers/qalc.sh")
    end, { description = "rofi calc", group = "rofi" }),

    awful.key({ modkey }, ",", function()
        awful.spawn.with_shell("~/.config/rofi/scripts/symbols.sh")
    end, { description = "rofi symbols", group = "rofi" }),

    awful.key({ modkey, "Shift" }, ",", function()
        awful.spawn.with_shell("~/.config/rofi/scripts/colors.sh")
    end, { description = "rofi symbols", group = "rofi" })
)

-- 1}}}
-- Tags {{{1

global_keybinds = gears.table.join(
    global_keybinds,
    awful.key(
        { modkey, "Shift" },
        "Tab",
        awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),
    awful.key(
        { modkey },
        "Tab",
        awful.tag.viewnext,
        { description = "view next", group = "tag" }
    ),
    awful.key({ modkey }, "/", function()
        awful.layout.inc(1)
    end, { description = "select next layout", group = "layout" })
)

local tags_keys = { "q", "w", "e" }
for i, key in ipairs(tags_keys) do
    global_keybinds = gears.table.join(
        global_keybinds,
        awful.key({ modkey }, key, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = "view tag #" .. i, group = "tag" }),
        awful.key(
            { modkey, "Control" },
            key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            { description = "move focused client to tag #" .. i, group = "tag" }
        )
    )
end

-- 1}}}

root.keys(global_keybinds)

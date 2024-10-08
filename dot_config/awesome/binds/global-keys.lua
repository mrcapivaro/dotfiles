local gears = require("gears")
local awful = require("awful")

local modkey = require("main.variables").modkey

local M = gears.table.join(
-- {{{ Tags
    awful.key(
        { modkey },
        "Left",
        awful.tag.viewprev,
        { description = "view previous", group = "tag" }
    ),
    awful.key(
        { modkey },
        "Right",
        awful.tag.viewnext,
        { description = "view next", group = "tag" }
    ),
    awful.key(
        { modkey },
        "Tab",
        awful.tag.history.restore,
        { description = "go back", group = "tag" }
    ),
    -- }}}

    -- Relative Client Focus Movement
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

    -- TODO: Resize Client

    -- Relative Client Swap
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
    }),

    -- awful.key(
    --   { modkey },
    --   "u",
    --   awful.client.urgent.jumpto,
    --   { description = "jump to urgent client", group = "client" }
    -- ),

    -- awful.key({ modkey }, "Tab", function()
    --   awful.client.focus.history.previous()
    --   if client.focus then
    --     client.focus:raise()
    --   end
    -- end, { description = "go back", group = "client" }),

    -- Standard program
    -- awful.key({ modkey }, "Return", function()
    -- 	awful.spawn("rofi -show drun")
    -- end, { description = "open rofi", group = "launcher" }),

    awful.key(
        { modkey },
        "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    -- awful.key(
    --   { modkey, "Control" },
    --   "q",
    --   awesome.quit,
    --   { description = "quit awesome", group = "awesome" }
    -- ),

    -- awful.key(
    --   { modkey, "Shift" },
    --   "h",
    --   function()
    --     awful.tag.incnmaster(1, nil, true)
    --   end,
    --   { description = "increase the number of master clients", group = "layout" }
    -- ),

    -- awful.key(
    --   { modkey, "Shift" },
    --   "l",
    --   function()
    --     awful.tag.incnmaster(-1, nil, true)
    --   end,
    --   { description = "decrease the number of master clients", group = "layout" }
    -- ),

    -- awful.key({ modkey, "Control" }, "h", function()
    --   awful.tag.incncol(1, nil, true)
    -- end, { description = "increase the number of columns", group = "layout" }),

    -- awful.key({ modkey, "Control" }, "l", function()
    --   awful.tag.incncol(-1, nil, true)
    -- end, { description = "decrease the number of columns", group = "layout" }),

    awful.key({ modkey }, "space", function()
        awful.layout.inc(1)
    end, { description = "select next", group = "layout" }),

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

    awful.key({}, "Print", function()
        -- awful.spawn(
        --   "scrot -s -o /dev/stdout | xclip -selection clipboard -t image/png"
        -- )
        awful.spawn(
            "scrot -s --exec 'xclip -selection clipboard -t image/png -i $f && rm $f'"
        )
    end, { description = "Print Screen", group = "other" }),

    -- Rofi
    awful.key({ "Mod1" }, "Tab", function()
        -- awful.client.focus.byidx(1)
        -- NOTE: require `xdotool` and `rofi` to work
        local command = {
            "rofi",
            "-modes window",
            "-show window",
            "-kb-element-next 'Alt+Tab'",
            "-kb-accept-entry '!Alt+Tab'",
        }
        awful.spawn.with_shell(table.concat(command, " "))
        awful.spawn.with_shell("xdotool key --delay 200 a")
    end, { description = "focus next by index", group = "client" }),
    awful.key({ "Mod1", "Shift" }, "Tab", function()
        awful.client.focus.byidx(-1)
    end, { description = "focus previous by index", group = "client" }),
    awful.key({ modkey }, "Return", function()
        local command = {
            "rofi",
            "-show drun",
            "-modes drun",
        }
        awful.spawn(table.concat(command, " "))
    end, { description = "rofi dmenu", group = "launcher" }),
    awful.key({ modkey, "Control" }, "Return", function()
        awful.spawn("rofi -modes calc -show calc")
    end, { description = "rofi calc", group = "launcher" })
)

local tags_keys = { "q", "w", "e" }
for i, key in ipairs(tags_keys) do
    M = gears.table.join(
        M,
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

return M

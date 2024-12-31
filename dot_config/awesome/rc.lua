-- ~/.config/awesome/rc.lua

-- Ensure that LuaRocks libraries can be called.
pcall(require, "luarocks.loader")

-- Require builtin libraries.
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Require external libraries.
local util = require("modules.util")
local poppin = require("modules.poppin")
local cyclefocus = require("modules.cyclefocus")
local gruvbox = require("modules.gruvbox")

-- Error Handling {{{1

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors,
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err),
        })
        in_error = false
    end)
end

-- 1}}}
-- Global Keybinds {{{1

local modkey = "Mod4"
local global_keybinds = {}

-- Misc {{{2

global_keybinds = gears.table.join(
    global_keybinds,

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
        util.x11.next_layout,
        { description = "Next xkb keyboard layout.", group = "keyboard" }
    )
)

-- 2}}}
-- Print Screen {{{2

global_keybinds = gears.table.join(
    global_keybinds,

    awful.key({}, "Print", function()
        awful.spawn.with_shell(
            "maim -m 10 -s | xclip -selection clipboard -t image/png"
        )
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
        -- import is from image magick
        awful.spawn.with_shell("import -window root png:- | display")
    end, {
        description = "open screenshot in image editor",
        group = "screenshot",
    })
)

-- 2}}}
-- Clients {{{2

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
    -- BUG: does not work
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

-- 2}}}
-- Alt + Tab {{{2

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

-- 2}}}
-- Scratchpads {{{2

local scratchpad_init_cb = function(c)
    c.titlebars_enabled = false
end

global_keybinds = gears.table.join(
    global_keybinds,
    awful.key({ modkey }, "a", function()
        poppin.pop("terminal", "ghostty", "center", 750, scratchpad_init_cb)
    end, { description = "scratchpad: terminal", group = "scratchpad" }),

    awful.key({ modkey }, "s", function()
        poppin.pop(
            "music",
            "flatpak run com.spotify.Client",
            "center",
            750,
            scratchpad_init_cb
        )
    end, { description = "scratchpad: music app", group = "scratchpad" }),

    awful.key({ modkey }, "d", function()
        poppin.pop(
            "browser",
            "firefox --private-window",
            "center",
            750,
            scratchpad_init_cb
        )
    end, { description = "scratchpad: browser", group = "scratchpad" })
)

-- 2}}}
-- Rofi {{{2

global_keybinds = gears.table.join(
    global_keybinds,
    awful.key({ modkey }, "Return", function()
        awful.spawn.with_shell("~/.config/rofi/launchers/apps.sh")
    end, { description = "rofi dmenu", group = "rofi" }),

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

-- 2}}}
-- Tags {{{2

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

-- 2}}}

root.keys(global_keybinds)

-- 1}}}
-- Clients and Tags {{{1

-- Client Keybinds and Buttons {{{2

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

-- 2}}}
-- Client Rules {{{2

-- Used to allow automatic change of focus when clients are killed or created.
require("awful.autofocus")

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
                "discord",
                "zenity",
            },
            name = {
                "Event Tester",
                "spotify",
            },
            role = {
                "AlarmWindow",
                "ConfigManager",
                "toolbox",
            },
            type = {
                "dialog",
                "toolbox",
            },
        },
        properties = {
            floating = true,
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

-- 2}}}
-- Client Signals {{{2

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
            c.titlebars_enabled = c.floating and not poppin.isPoppin(c)
            if c.floating then
                awful.placement.centered(c)
            end
        end,
        titlebars_enabled = function(c)
            if c.titlebars_enabled then
                awful.titlebar.show(c)
            else
                awful.titlebar.hide(c)
            end
        end,
        requests_no_titlebar = function(c)
            if c.requests_no_titlebar then
                c.titlebars_enabled = false
            end
        end,
        fullscreen = function(c)
            if not c.fullscreen then
                return
            end
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

-- 2}}}
-- Tags Creation and Behavior {{{2

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

awful.screen.connect_for_each_screen(function(s)
    -- Setup a set of tags for each screen.
    -- Symbols:  
    awful.tag({ "", "", "" }, s, awful.layout.layouts[1])
end)

-- Set all clients to floating when the layout changes to floating.
awful.tag.attached_connect_signal(nil, "property::layout", function(t)
    local float = t.layout.name == "floating"
    for _, c in pairs(t:clients()) do
        c.floating = float
    end
end)

-- 2}}}

-- 1}}}
-- Theming and Widgets {{{1

-- Theming Bootstrap {{{2

local colors = gruvbox.dark
local config_dir = gears.filesystem.get_configuration_dir()

awesome.set_preferred_icon_size(16)
beautiful.init()

util.populate_beautiful("", {
    path = config_dir .. "modules/gruvbox/",
    icons_path = config_dir .. "modules/gruvbox/icons/",
    default_path = gears.filesystem.get_themes_dir(),

    icon_theme = "Papirus",
    useless_gap = 2,
    gap_single_client = true,
    fullscreen_hide_border = true,
    maximized_hide_border = true,

    font = {
        name = "Ubuntu Nerd Font",
        weight = "Medium",
        size = "9",
    },

    bg = {
        normal = colors.bg0,
        focus = colors.bg1,
        urgent = colors.red,
    },

    fg = {
        normal = colors.fg0,
        focus = colors.yellow,
        urgent = colors.red,
    },
})

-- 2}}}

---Unique to each client.
-- Client Titlebar {{{2

awful.titlebar.enable_tooltip = false

local title_icons = beautiful.icons_path .. "titlebar/"
util.populate_beautiful("titlebar", {
    fg = colors.fg0,
    bg = colors.bg0,

    close_button = {
        normal = {
            title_icons .. "close.svg",
            hover = title_icons .. "close_hover.svg",
        },
        focus = {
            title_icons .. "close.svg",
            hover = title_icons .. "close_hover.svg",
        },
    },

    maximized_button = {
        normal = {
            inactive = title_icons .. "maximize.svg",
            inactive_hover = title_icons .. "maximize_hover.svg",
            active = title_icons .. "maximize_active.svg",
            active_hover = title_icons .. "maximize_active_hover.svg",
        },
        focus = {
            inactive = title_icons .. "maximize.svg",
            inactive_hover = title_icons .. "maximize_hover.svg",
            active = title_icons .. "maximize_active.svg",
            active_hover = title_icons .. "maximize_active_hover.svg",
        },
    },

    minimize_button = {
        normal = {
            title_icons .. "minimize.svg",
            hover = title_icons .. "minimize_hover.svg",
        },
        focus = {
            title_icons .. "minimize.svg",
            hover = title_icons .. "minimize_hover.svg",
        },
    },

    ontop_button = {
        normal = {
            inactive = title_icons .. "ontop.svg",
            inactive_hover = title_icons .. "ontop_hover.svg",
            active = title_icons .. "ontop_active.svg",
            active_hover = title_icons .. "ontop_active_hover.svg",
        },
        focus = {
            inactive = title_icons .. "ontop.svg",
            inactive_hover = title_icons .. "ontop_hover.svg",
            active = title_icons .. "ontop_active.svg",
            active_hover = title_icons .. "ontop_active_hover.svg",
        },
    },
})

client.connect_signal("request::titlebars", function(c)
    awful.titlebar.fallback_name = "fallback"

    c.titlebar = awful.titlebar(c, { size = 24 })

    local titlebar_buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    c.titlebar:setup({
        layout = wibox.layout.align.horizontal,
        {
            widget = wibox.container.margin,
            margins = 4,
            {
                layout = wibox.layout.fixed.horizontal,
                awful.titlebar.widget.ontopbutton(c),
            },
        },
        {
            {
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = titlebar_buttons,
            layout = wibox.layout.flex.horizontal,
        },
        {
            widget = wibox.container.margin,
            margins = 4,
            {
                layout = wibox.layout.fixed.horizontal,
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
            },
        },
    })
end)

-- 2}}}
-- Borders {{{2

util.populate_beautiful("border", {
    color = {
        normal = colors.bg1,
        active = colors.bg4,
    },

    width = {
        normal = 1,
        active = 1,
    },
})

-- Dynamic border colors
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_color_normal
    c.border_width = beautiful.border_width_normal
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_color_active
    c.border_width = beautiful.border_width_active
end)

-- 2}}}

---Not unique to each screen.
-- Launcher {{{2

util.populate_beautiful("menu", {
    height = 32,
    width = 120,
    bg = {
        normal = colors.bg0,
        focus = colors.bg1,
    },
    submenu_icon = beautiful.icons_path .. "/void.svg",
})

local launcher = awful.widget.launcher({
    image = beautiful.menu_submenu_icon,
    menu = awful.menu({
        items = {
            {
                "󰐥   Poweroff",
                function()
                    awesome.spawn("loginctl poweroff")
                end,
            },
            {
                "󰑓   Reboot",
                function()
                    awesome.spawn("loginctl reboot")
                end,
            },
            {
                "󰤄   Sleep",
                function()
                    awesome.spawn("loginctl hybrid-sleep")
                end,
            },
            {
                "   Logoff",
                awesome.quit,
            },
        },
    }),
})

-- 2}}}
-- Keyboard Box {{{2

local keyboardbox = awful.widget.keyboardlayout()

-- 2}}}
-- Systray {{{2

util.populate_beautiful("systray", {
    icon_spacing = 10,
    max_rows = 1,
})

local systray = wibox.widget.systray()

-- 2}}}
-- Date & Time {{{2

-- https://awesomewm.org/apidoc/widgets/wibox.widget.textclock.html
-- %a: name of the current day
-- %b: name of the current month
-- %d: digit of the day
-- %m: digit of the month
-- %Y: full number of the year
-- %y: last two digits of the year
-- %M: current minute
-- %H: current hour
local date = wibox.widget.textclock("%b %d, %a")
local time = wibox.widget.textclock("%H:%M")

-- 2}}}
-- Notifications {{{2

util.populate_beautiful("notifications", {
    bg = {
        normal = colors.bg4,
    },
    fg = {
        normal = colors.red,
    },
    border = {
        width = 0,
        color = colors.fg0,
    },
})

-- 2}}}

---Unique to each screen.
-- Tasklist {{{2

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end)
)

util.populate_beautiful("tasklist", {
    fg = {
        normal = colors.fg0,
        focus = colors.yellow,
        urgent = colors.red,
        minimize = colors.fg0,
    },
    bg = {
        normal = colors.orange,
        focus = colors.yellow,
        urgent = colors.red,
        minimize = colors.blue,
    },
})

awful.screen.connect_for_each_screen(function(s)
    s.tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = 8,
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            layout = wibox.layout.stack,
            -- {
            --     wibox.widget.base.make_widget(),
            --     id = "background_role",
            --     forced_height = 2,
            --     forced_width = 16,
            --     widget = wibox.container.background,
            -- },
            {
                id = "clienticon",
                widget = awful.widget.clienticon,
            },
            ---@diagnostic disable-next-line: unused-local
            create_callback = function(self, c, index, objects)
                self:get_children_by_id("clienticon")[1].client = c
            end,
            ---@diagnostic disable-next-line: unused-local
            -- update_callback = function(self, c, index, objects)
            --     -- self:get_children_by_id("clienticon")[1].client = c
            -- end,
        },
    })
end)

-- 2}}}
-- Taglist {{{2

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

util.populate_beautiful("taglist", {
    font = {
        family = "Inter",
        weight = "Bold",
        size = 15,
    },
    spacing = 4,
    disable_icon = nil,
    fg = {
        focus = colors.orange,
        urgent = colors.red,
        occupied = colors.fg0,
        empty = colors.fg0,
        volatile = colors.fg0,
    },
    bg = {
        focus = colors.bg0,
        urgent = colors.bg0,
        occupied = colors.bg0,
        empty = colors.bg0,
        volatile = colors.bg0,
    },
})

awful.screen.connect_for_each_screen(function(s)
    -- Create taglist widget object for each screen.
    s.taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        -- ---@diagnostic disable-next-line: unused-local
        -- update_callback = function(self, t, index, tags)
        -- end,
    })
end)

-- 2}}}
-- Layout Box {{{2

local layout_icons_path = beautiful.default_path .. "default/layouts/"
util.populate_beautiful("layout", {
    fairh = layout_icons_path .. "fairhw.png",
    fairv = layout_icons_path .. "fairvw.png",
    floating = layout_icons_path .. "floatingw.png",
    magnifier = layout_icons_path .. "magnifierw.png",
    max = layout_icons_path .. "maxw.png",
    fullscreen = layout_icons_path .. "fullscreenw.png",
    tilebottom = layout_icons_path .. "tilebottomw.png",
    tileleft = layout_icons_path .. "tileleftw.png",
    tile = layout_icons_path .. "tilew.png",
    tiletop = layout_icons_path .. "tiletopw.png",
    spiral = layout_icons_path .. "spiralw.png",
    dwindle = layout_icons_path .. "dwindlew.png",
    cornernw = layout_icons_path .. "cornernww.png",
    cornerne = layout_icons_path .. "cornernew.png",
    cornersw = layout_icons_path .. "cornersww.png",
    cornerse = layout_icons_path .. "cornersew.png",
})

local layoutbox_buttons = gears.table.join(
    awful.button({}, 1, function()
        awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
        awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
        awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
        awful.layout.inc(-1)
    end)
)

awful.screen.connect_for_each_screen(function(s)
    s.layoutbox = awful.widget.layoutbox(s)
    s.layoutbox:buttons(layoutbox_buttons)
end)

-- 2}}}
-- Wibar {{{2

util.populate_beautiful("wibar", {
    height = 24,
    border_width = 1,
    border_color = colors.bg4,
    stretch = true,
})

awful.screen.connect_for_each_screen(function(s)
    s.wibar = awful.wibar({ position = "bottom", screen = s })
    s.wibar:setup({
        {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 4,
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
                spacing = 4,
                keyboardbox,
                {
                    systray,
                    widget = wibox.container.place,
                    valign = "bottom",
                },
                date,
                time,
            },
        },
        widget = wibox.container.margin,
        left = 8,
        right = 8,
        top = 4,
        bottom = 4,
    })
end)

-- 2}}}

-- 1}}}
-- After {{{1

-- Collect garbage every 30 seconds to prevent memory leaks.
-- source: https://wiki.archlinux.org/title/Awesome#Memory_leaks
gears.timer({
    timeout = 30,
    autostart = true,
    callback = function()
        collectgarbage()
    end,
})

awful.spawn.with_shell("~/.config/awesome/autostart.sh")

-- 1}}}

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

--{{{1 Error Handling
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
--1}}}

--{{{1 Key Binds

local modkey = "Mod4"

--{{{2 Global Key Binds

local keybinds = gears.table.join(
    awful.key({ modkey }, "t", function()
        util.toggle_colorscheme()
        awesome.restart()
    end, {
        description = "Toggle theme's colorscheme",
        group = "theme",
    }),

    awful.key(
        { modkey },
        "r",
        awesome.restart,
        { description = "reload awesome", group = "awesome" }
    ),

    awful.key({ modkey }, ",", function()
        awful.spawn.with_shell("xdotool key --delay 100 Scroll_Lock")
    end, { description = "screenshot", group = "other" }),

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

    awful.key(
        { "Control" },
        "Print",
        function()
            -- import is from image magick
            awful.spawn.with_shell("import -window root png:- | display")
        end,
        { description = "open screenshot in image editor", group = "screenshot" }
    ),

    --{{{3 Tags
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
    awful.key({ modkey }, ".", function()
        awful.layout.inc(1)
    end, { description = "select next layout", group = "layout" }),
    --3}}}

    --{{{3 Clients
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
    }),

    --3}}}

    --{{{3 Alt + Tab

    cyclefocus.key({ "Mod1" }, "Tab", {
        cycle_filters = {},
        move_mouse_pointer = false,
        keys = { "Tab", "ISO_Left_Tab" },
    }),
    cyclefocus.key({ "Mod1", "Shift" }, "Tab", {
        cycle_filters = {},
        move_mouse_pointer = false,
        keys = { "Tab", "ISO_Left_Tab" },
    }),

    --3}}}

    --{{{3 Poppin Scratchpads

    awful.key({ modkey }, "a", function()
        poppin.pop("terminal", "wezterm", "center", 750)
    end, { description = "scratchpad: terminal", group = "scratchpad" }),

    awful.key({ modkey }, "s", function()
        poppin.pop(
            "music",
            "flatpak run com.spotify.Client",
            "center",
            750,
            function(c)
                c.poppin = true
            end
        )
    end, { description = "scratchpad: music app", group = "scratchpad" }),

    awful.key({ modkey }, "d", function()
        poppin.pop("browser", "firefox --private-window", "center", 750)
    end, { description = "scratchpad: browser", group = "scratchpad" }),

    --3}}}

    --{{{3 Rofi

    awful.key({ modkey }, "Return", function()
        awful.spawn.with_shell("~/.config/rofi/scripts/launcher.sh")
    end, { description = "rofi dmenu", group = "rofi" }),

    awful.key({ modkey }, "x", function()
        awful.spawn.with_shell("~/.config/rofi/scripts/qalc.sh")
    end, { description = "rofi calc", group = "rofi" }),

    awful.key({ modkey }, ",", function()
        awful.spawn.with_shell("~/.config/rofi/scripts/symbols.sh")
    end, { description = "rofi symbols", group = "rofi" }),

    awful.key({ modkey, "Control" }, "r", function()
        awful.spawn.with_shell("~/.config/rofi/scripts/powermenu.sh")
    end, { description = "rofi powermenu", group = "rofi" })

    --3}}}
)

--{{{3 Tag Keys

local tags_keys = { "q", "w", "e" }
for i, key in ipairs(tags_keys) do
    keybinds = gears.table.join(
        keybinds,
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

--3}}}

--2}}}

--{{{2 Client Key Binds

local client_keys = gears.table.join(
    awful.key({ modkey, "Shift" }, "m", function(c)
        awful.client.setmaster(c)
    end, { description = "set master", group = "client" }),

    awful.key({ "Mod1" }, "Return", function(c)
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

--2}}}

root.keys(keybinds)

--1}}}

--{{{1 Theming

-- Theming module bootstrap
local config_dir = gears.filesystem.get_configuration_dir
beautiful.init({
    path = config_dir(),
    icons_path = config_dir() .. "/icons/",
    default_path = gears.filesystem.get_themes_dir(),
})

awesome.set_preferred_icon_size(16)

--{{{2 Colorschemes

beautiful.colorschemes = {}

beautiful.colorschemes.catppuccin = {
    mocha = {
        rosewater = "#f5e0dc",
        flamingo = "#f2cdcd",
        pink = "#f5c2e7",
        mauve = "#cba6f7",
        red = "#f38ba8",
        maroon = "#eba0ac",
        peach = "#fab387",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        teal = "#94e2d5",
        sky = "#89dceb",
        sapphire = "#74c7ec",
        blue = "#89b4fa",
        lavender = "#b4befe",
        text = "#cdd6f4",
        subtext1 = "#bac2de",
        subtext0 = "#a6adc8",
        overlay2 = "#9399b2",
        overlay1 = "#7f849c",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
        surface1 = "#45475a",
        surface0 = "#313244",
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
    },

    latte = {
        rosewater = "#dc8a78",
        flamingo = "#dd7878",
        pink = "#ea76cb",
        mauve = "#8839ef",
        red = "#d20f39",
        maroon = "#e64553",
        peach = "#fe640b",
        yellow = "#df8e1d",
        green = "#40a02b",
        teal = "#179299",
        sky = "#04a5e5",
        sapphire = "#209fb5",
        blue = "#1e66f5",
        lavender = "#7287fd",
        text = "#4c4f69",
        subtext1 = "#5c5f77",
        subtext0 = "#6c6f85",
        overlay2 = "#7c7f93",
        overlay1 = "#8c8fa1",
        overlay0 = "#9ca0b0",
        surface2 = "#acb0be",
        surface1 = "#bcc0cc",
        surface0 = "#ccd0da",
        base = "#eff1f5",
        mantle = "#e6e9ef",
        crust = "#dce0e8",
    },

    machiatto = {
        rosewater = "#f4dbd6",
        flamingo = "#f0c6c6",
        pink = "#f5bde6",
        mauve = "#c6a0f6",
        red = "#ed8796",
        maroon = "#ee99a0",
        peach = "#f5a97f",
        yellow = "#eed49f",
        green = "#a6da95",
        teal = "#8bd5ca",
        sky = "#91d7e3",
        sapphire = "#7dc4e4",
        blue = "#8aadf4",
        lavender = "#b7bdf8",
        text = "#cad3f5",
        subtext1 = "#b8c0e0",
        subtext0 = "#a5adcb",
        overlay2 = "#939ab7",
        overlay1 = "#8087a2",
        overlay0 = "#6e738d",
        surface2 = "#5b6078",
        surface1 = "#494d64",
        surface0 = "#363a4f",
        base = "#24273a",
        mantle = "#1e2030",
        crust = "#181926",
    },

    frappe = {
        rosewater = "#f2d5cf",
        flamingo = "#eebebe",
        pink = "#f4b8e4",
        mauve = "#ca9ee6",
        red = "#e78284",
        maroon = "#ea999c",
        peach = "#ef9f76",
        yellow = "#e5c890",
        green = "#a6d189",
        teal = "#81c8be",
        sky = "#99d1db",
        sapphire = "#85c1dc",
        blue = "#8caaee",
        lavender = "#babbf1",
        text = "#c6d0f5",
        subtext1 = "#b5bfe2",
        subtext0 = "#a5adce",
        overlay2 = "#949cbb",
        overlay1 = "#838ba7",
        overlay0 = "#737994",
        surface2 = "#626880",
        surface1 = "#51576d",
        surface0 = "#414559",
        base = "#303446",
        mantle = "#292c3c",
        crust = "#232634",
    },
}

beautiful.colorschemes.gruvbox = {
    dark = {
        bg0 = "#282828",
        bg1 = "#3c3836",
        bg2 = "#504945",
        bg3 = "#665c54",
        bg4 = "#7c6f64",
        fg0 = "#fbf1c7",
        fg1 = "#ebdbb2",
        fg2 = "#d5c4a1",
        fg3 = "#bdae93",
        fg4 = "#a89984",
        red = "#fb4934",
        green = "#b8bb26",
        yellow = "#fabd2f",
        blue = "#83a598",
        purple = "#d3869b",
        aqua = "#8ec07c",
        orange = "#fe8019",
        neutral_red = "#cc241d",
        neutral_green = "#98971a",
        neutral_yellow = "#d79921",
        neutral_blue = "#458588",
        neutral_purple = "#b16286",
        neutral_aqua = "#689d6a",
        dark_red = "#722529",
        dark_green = "#62693e",
        dark_aqua = "#49503b",
        gray = "#928374",
    },

    light = {
        bg0 = "#fbf1c7",
        bg1 = "#ebdbb2",
        bg2 = "#d5c4a1",
        bg3 = "#bdae93",
        bg4 = "#a89984",
        fg0 = "#282828",
        fg1 = "#3c3836",
        fg2 = "#504945",
        fg3 = "#665c54",
        fg4 = "#7c6f64",
        red = "#9d0006",
        green = "#79740e",
        yellow = "#b57614",
        blue = "#076678",
        purple = "#8f3f71",
        aqua = "#427b58",
        orange = "#af3a03",
        neutral_red = "#cc241d",
        neutral_green = "#98971a",
        neutral_yellow = "#d79921",
        neutral_blue = "#458588",
        neutral_purple = "#b16286",
        neutral_aqua = "#689d6a",
        dark_red = "#fc9487",
        dark_green = "#d5d39b",
        dark_aqua = "#e8e5b5",
        gray = "#928374",
    },
}

-- Set the current colorscheme
local colors = beautiful.colorschemes.gruvbox.dark

--2}}}

util.populate_beautiful("", {
    icon_theme = "Papirus",
    gap_single_client = true,
    useless_gap = 2,
    fullscreen_hide_border = true,
    maximized_hide_border = false,
    maximized_honor_padding = true,

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

--1}}}

--{{{1 Widgets

---Unique to each client.

--{{{2 Client Titlebar

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
            active = title_icons .. "maximize-active.svg",
            active_hover = title_icons .. "maximize-active_hover.svg",
        },
        focus = {
            inactive = title_icons .. "maximize.svg",
            inactive_hover = title_icons .. "maximize_hover.svg",
            active = title_icons .. "maximize-active.svg",
            active_hover = title_icons .. "maximize-active_hover.svg",
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
        nil,
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
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.closebutton(c),
                layout = wibox.layout.fixed.horizontal,
            },
        },
    })
end)

--2}}}

--{{{2 Borders

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

--2}}}

---Not unique to each screen.

--{{{2 Launcher
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
--2}}}

--{{{2 Keyboard Box
local keyboardbox = awful.widget.keyboardlayout()
--2}}}

--{{{2 Systray
util.populate_beautiful("systray", {
    icon_spacing = 10,
    max_rows = 1,
})

local systray = wibox.widget.systray()
--2}}}

--{{{2 Date & Time
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
--2}}}

--{{{2 Notifications

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

--2}}}

---Unique to each screen.

--{{{2 Tasklist
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
--2}}}

--{{{2 Taglist
awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
    awful.layout.suit.max,
}

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
    -- Setup a set of tags for each screen.
    -- Symbols:  
    awful.tag({ "", "", "" }, s, awful.layout.layouts[1])

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
--2}}}

--{{{2 Layout Box
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
--2}}}

--{{{2 Wibar
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
--2}}}

--1}}}

--{{{1 Client Rules
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

    -- emacs not occupying all screen space in tile mode bug.
    -- source: https://superuser.com/questions/751075/emacs-maximized-but-leaves-few-pixels-in-awesome-wm
    {
        rule = { class = "Emacs" },
        properties = { size_hints_honor = false },
    },
}
--1}}}

--{{{1 WM Signals
-- Used to allow automatic change of focus when clients are killed or created.
require("awful.autofocus")

-- The "manage" signal triggers when a client starts.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if
        awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position
    then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Adjust the geometry of fullscreen clients to always cover the entire screen.
client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        gears.timer.delayed_call(function()
            if c.valid then
                c:geometry(c.screen.geometry)
            end
        end)
    end
end)

-- Set all clients to floating when the layout changes to floating.
awful.tag.attached_connect_signal(nil, "property::layout", function(t)
    local float = t.layout.name == "floating"
    for _, c in pairs(t:clients()) do
        c.floating = float
    end
end)

client.connect_signal("property::floating", function(c)
    -- Center floating clients.
    awful.placement.centered(c)

    -- Enable titlebars on floating clients
    c.titlebars_enabled = c.floating
    if c.floating then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end
end)

--}}}

--{{{1 After
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
--1}}}

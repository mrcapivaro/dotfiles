-- Documentation for the beautiful module properties:
-- https://awesomewm.org/doc/api/documentation/06-appearance.md.html

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local util = require("modules.util")
local theme = require("modules.theme")

local modkey = "Mod4"

-- Theming Bootstrap {{{1

local colors = theme.colors.dark
local config_dir = gears.filesystem.get_configuration_dir()

beautiful.init()

util.populate_beautiful("", {
    path = config_dir .. "/modules/theme/",
    icons_path = config_dir .. "/modules/theme/icons/",
    default_path = gears.filesystem.get_themes_dir(),

    -- Does not seem to change anything
    -- icon_theme = "Papirus",

    -- Gaps
    useless_gap = 0,
    gap_single_client = false,

    -- Fullscreen and Maximized
    fullscreen_hide_border = true,
    maximized_hide_border = true,
    maximized_honor_padding = true,

    font = {
        name = "Ubuntu Nerd Font",
        weight = "Bold",
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

-- 1}}}

-- Constructors {{{

-- Widget colored icon
local function colored_icon_wrapper(color, icon, wgt, width)
    return wibox.widget({
        widget = wibox.container.place,
        valign = "center",
        {
            layout = wibox.layout.fixed.vertical,
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    image = icon,
                    widget = wibox.widget.imagebox,
                    resize = true,
                    forced_height = 10,
                    forced_width = 10,
                },
                wgt,
            },
            {
                widget = wibox.container.place,
                valign = "bottom",
                {
                    widget = wibox.widget.separator,
                    thickness = 2,
                    forced_height = 2,
                    forced_width = width,
                    color = color,
                },
            },
        },
    })
end

-- }}}

-- Notifications {{{1

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

-- 1}}}
-- Client Titlebar {{{1

awful.titlebar.enable_tooltip = false
awful.titlebar.fallback_name = "fallback"

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

    c.titlebar = awful.titlebar(c, { size = 24 })
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

-- 1}}}
-- Borders {{{1

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

-- 1}}}

-- Date & Time {{{1
-- https://awesomewm.org/apidoc/widgets/wibox.widget.textclock.html

local calendar_and_clock = wibox.widget({
    widget = wibox.container.place,
    valign = "center",
    {
        layout = wibox.layout.fixed.vertical,
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = 3,
            {
                image = beautiful.icons_path .. "/widgets/calendar.svg",
                resize = true,
                widget = wibox.widget.imagebox,
                forced_height = 20,
                forced_width = 20,
            },
            wibox.widget.textclock("%b %d, %a"),
            {
                image = beautiful.icons_path .. "/widgets/clock.svg",
                resize = true,
                widget = wibox.widget.imagebox,
                forced_height = 20,
                forced_width = 20,
            },
            wibox.widget.textclock("%H:%M"),
        },
        {
            widget = wibox.container.place,
            valign = "bottom",
            {
                widget = wibox.widget.separator,
                thickness = 2,
                forced_height = 2,
                forced_width = 150,
                color = colors.red,
            },
        },
    },
})

-- 1}}}
-- Keyboard Box {{{

local keyboardlayout = require("modules.theme.widgets.keyboardlayout")
local keyboardbox = colored_icon_wrapper(
    colors.orange,
    beautiful.icons_path .. "/widgets/keyboardbox.svg",
    keyboardlayout(),
    28
)

-- }}}
-- Systray {{{1

util.populate_beautiful("systray", {
    icon_spacing = 4,
    max_rows = 1,
})

local systray = wibox.widget({
    widget = wibox.container.margin,
    margins = 4,
    wibox.widget.systray(),
})

-- 1}}}

-- Tasklist {{{1

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
        normal = colors.bg1,
        focus = colors.bg2,
        minimize = colors.bg0,
        urgent = colors.bg1,
    },
})

awful.screen.connect_for_each_screen(function(s)
    s.tasklist = awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = 2,
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            layout = wibox.layout.stack,
            {
                id = "background_role",
                widget = wibox.container.background,
                {
                    widget = wibox.container.margin,
                    margins = 3,
                    {
                        id = "clienticon",
                        widget = awful.widget.clienticon,
                    },
                },
            },
            {
                widget = wibox.container.place,
                valign = "bottom",
                {
                    id = "bar",
                    widget = wibox.widget.separator,
                    -- FIX: Height and width need to be hardcoded.
                    thickness = 2,
                    forced_height = 2,
                    forced_width = 24,
                    ----------------------------------------------
                    color = colors.green,
                    orientation = "horizontal",
                },
            },
            ---@diagnostic disable-next-line: unused-local
            create_callback = function(self, c, index, objects)
                self:get_children_by_id("clienticon")[1].client = c
                local bar = self:get_children_by_id("bar")[1]
                bar.visible = c == client.focus
            end,
            ---@diagnostic disable-next-line: unused-local
            update_callback = function(self, c, index, objects)
                local bar = self:get_children_by_id("bar")[1]
                bar.visible = c == client.focus
            end,
        },
    })
end)

-- 1}}}

-- Launcher {{{1

util.populate_beautiful("menu", {
    height = 24,
    width = 120,
    bg = {
        normal = colors.bg1,
        focus = colors.bg2,
    },
    submenu_icon = beautiful.icons_path .. "/void.svg",
})

local launcher = wibox.widget({
    widget = wibox.container.margin,
    margins = 4,
    awful.widget.launcher({
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
    }),
})

-- 1}}}
-- Taglist {{{1

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
        family = "Ubuntu Mono Nerd",
        weight = "Bold",
        size = 11,
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
        -- widget_template = {
        --     layout = awful.layout.fixed.horizontal,
        --     {
        --         id = "index",
        --         widget = wibox.widget.textbox,
        --     },
        --     ---@diagnostic disable-next-line: unused-local
        --     create_callback = function(self, t, index, tags)
        --         util.print(self)
        --         util.print(t)
        --         util.print(index)
        --         util.print(tags)
        --     end,
        -- },
    })
end)

-- 1}}}
-- Layout Box {{{1

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
    s.layoutbox = wibox.widget({
        widget = wibox.container.margin,
        margins = 4,
        awful.widget.layoutbox(s),
    })
    s.layoutbox:buttons(layoutbox_buttons)
end)

-- 1}}}

-- Wibar {{{1

util.populate_beautiful("wibar", { height = 25 })

awful.screen.connect_for_each_screen(function(s)
    s.wibar = awful.wibar({ position = "bottom", screen = s })

    s.wibar:setup({
        widget = wibox.container.margin,
        left = 8,
        right = 8,
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
                widget = wibox.container.place,
                s.tasklist,
            },
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = 4,
                {
                    systray,
                    widget = wibox.container.place,
                    valign = "bottom",
                },
                keyboardbox,
                calendar_and_clock,
            },
        },
    })
end)

-- 1}}}

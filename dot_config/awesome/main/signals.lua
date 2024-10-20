local awful = require("awful")
local beautiful = require("beautiful")

-- manage: when a client appears
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

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    local titlebar = require("widgets.titlebar")
    titlebar(c)
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

awful.tag.attached_connect_signal(nil, "property::layout", function(t)
    local float = t.layout.name == "floating"
    for _, c in pairs(t:clients()) do
        c.floating = float
    end
end)

-- The rules for floating windows already takes care of enabling titlebars for
-- newly created windows, but not for windows that have their "floating"
-- property changed after that.
client.connect_signal("property::floating", function(c)
    c.titlebars_enabled = c.floating
    if not c.floating then
        awful.titlebar.hide(c)
        return
    end
    awful.titlebar.show(c)
end)

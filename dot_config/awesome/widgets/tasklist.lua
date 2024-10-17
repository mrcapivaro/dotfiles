local awful = require("awful")
local wibox = require("wibox")

local tasklist_buttons = require("binds.tasklist-buttons")

local M = {}

M.options = {
    spacing = 4,
}

M.widget_template = {
    {
        -- id = "clienticon",
        -- awful.widget.clienticon,
        id = "icon_role",
        widget = wibox.widget.imagebox,
    },
    {
        wibox.widget.base.make_widget(),
        forced_height = 2,
        id = "background_role",
        widget = wibox.container.background,
        -- opacity = 0.3,
    },
    -- layout = wibox.layout.stack,
    layout = wibox.layout.fixed.vertical,
}

M.buttons = {}

local mt = {}

mt.__call = function(_, s)
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = M.options.spacing,
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = M.widget_template,
    })
end

setmetatable(M, mt)

return M

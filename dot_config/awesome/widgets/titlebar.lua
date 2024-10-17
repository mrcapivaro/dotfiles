local awful = require("awful")
local wibox = require("wibox")

local M = {}

M.options = {
    size = 20,
}

local mt = {}

mt.__call = function(_, c)
    local titlebar_buttons = require("binds.titlebar-buttons")(c)
    awful.titlebar(c, { size = M.options.size }):setup({
        { -- Left
            -- awful.titlebar.widget.iconwidget(c),
            buttons = titlebar_buttons,
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Middle
            {
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = titlebar_buttons,
            layout = wibox.layout.flex.horizontal,
        },
        { -- Right
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),
            layout = wibox.layout.fixed.horizontal(),
        },
        layout = wibox.layout.align.horizontal,
    })
end

setmetatable(M, mt)

return M

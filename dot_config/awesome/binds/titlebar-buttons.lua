local gears = require("gears")
local awful = require("awful")

local M = {}

local mt = {
    __call = function(_, c)
        return gears.table.join(
            awful.button({}, 1, function()
                c:emit_signal("request::activate", "titlebar", { raise = true })
                awful.mouse.client.move(c)
            end),
            awful.button({}, 3, function()
                c:emit_signal("request::activate", "titlebar", { raise = true })
                awful.mouse.client.resize(c)
            end)
        )
    end,
}

setmetatable(M, mt)

return M

local gears = require("gears")
local awful = require("awful")

local M = {}

local metatable = {
    __call = function(client)
        gears.table.join(
            awful.button({}, 1, function()
                client:emit_signal(
                    "request::activate",
                    "titlebar",
                    { raise = true }
                )
                awful.mouse.client.move(client)
            end),
            awful.button({}, 3, function()
                client:emit_signal(
                    "request::activate",
                    "titlebar",
                    { raise = true }
                )
                awful.mouse.client.resize(client)
            end)
        )
    end,
}

setmetatable(M, metatable)

return M

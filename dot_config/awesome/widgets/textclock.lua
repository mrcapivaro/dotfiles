local wibox = require("wibox")
-- local awful = require("awful")

local M = wibox.widget.textclock()
M:set_format("%d/%m/%Y %H:%M")

return M

local awful = require("awful")
local wibox = require("wibox")

local layoutbox_buttons = require("binds.layoutbox-buttons")

awful.screen.connect_for_each_screen(function(s)
  s.layoutbox = awful.widget.layoutbox(s)
  s.layoutbox:buttons(layoutbox_buttons)
end)

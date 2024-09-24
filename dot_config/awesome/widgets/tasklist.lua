local awful = require("awful")
local tasklist_buttons = require("binds.tasklist-buttons")

-- local widget_template = {}

awful.screen.connect_for_each_screen(function(s)
  s.tasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
    -- widget_template = widget_template,
  })
end)

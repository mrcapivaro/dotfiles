local awful = require("awful")
-- local wibox = require("wibox")
local taglist_buttons = require("binds.taglist-button")

awful.layout.layouts = {
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating,
}

awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])
    s.taglist = awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    })
end)

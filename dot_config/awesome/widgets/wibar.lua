local awful = require("awful")
local wibox = require("wibox")

local mytextclock = wibox.widget.textclock()
local mykeyboardlayout = awful.widget.keyboardlayout()
local mysystray = wibox.widget.systray()
mysystray.base_size = 18

local taglist_buttons = require("binds.taglist")
local tasklist_buttons = require("binds.tasklist")
local layoutbox_buttons = require("binds.layoutbox")

-- Create an Wibar for each screen
awful.screen.connect_for_each_screen(function(s)
  -- Create an imagebox widget which will contain an icon indicating which
  -- layout we're using. We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(layoutbox_buttons)

  -- Each screen has its own tag table.
  awful.tag({ "1", "2", "3" }, s, awful.layout.layouts[1])
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist({
    screen = s,
    filter = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
  })

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist({
    screen = s,
    filter = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons,
  })
  -- tasklist with no text
  -- s.mytasklist = awful.widget.tasklist({
  --   screen = s,
  --   filter = awful.widget.tasklist.filter.currenttags,
  --   buttons = tasklist_buttons,
  --   layout = {
  --     spacing_widget = {
  --       {
  --         forced_width = 24,
  --         forced_height = 5,
  --         thickness = 1,
  --         color = "#777777",
  --         widget = wibox.widget.separator,
  --       },
  --       valign = "center",
  --       halign = "center",
  --       widget = wibox.container.place,
  --     },
  --     spacing = 1,
  --     layout = wibox.layout.fixed.horizontal,
  --   },
  --   widget_template = {
  --     {
  --       wibox.widget.base.make_widget(),
  --       forced_height = 5,
  --       id = "background_role",
  --       widget = wibox.container.background,
  --     },
  --     {
  --       awful.widget.clienticon,
  --       margins = 5,
  --       widget = wibox.container.margin,
  --     },
  --     nil,
  --     layout = wibox.layout.align.vertical,
  --   },
  -- })

  -- Wibar itself
  s.mywibar = awful.wibar({ position = "top", screen = s })
  s.mywibar:setup({
    layout = wibox.layout.align.horizontal,
    {
      layout = wibox.layout.fixed.horizontal,
      s.mylayoutbox,
      s.mytaglist,
    },
    s.mytasklist,
    {
      layout = wibox.layout.fixed.horizontal,
      mysystray,
      mykeyboardlayout,
      mytextclock,
    },
  })
end)

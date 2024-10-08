local wibox = require("wibox")
local awful = require("awful")

local M = wibox.widget.textclock(" %a %d-%m-%Y ")

-- M:add_button(awful.button({}, 1, function()
--     -- call a calendar widget popup
--     --   - must open when clicking in the date widget
--     --   - must close with lost of focus
--     --   - must close when clicking in the date widget again
--     awful.menu.client_list({ theme = { width = 250 } })
-- end))

return M

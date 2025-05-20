local awful = require("awful")
local gears = require("gears")

-- Collect garbage every 30 seconds to prevent memory leaks.
-- source: https://wiki.archlinux.org/title/Awesome#Memory_leaks
gears.timer({
    timeout = 30,
    autostart = true,
    callback = function()
        collectgarbage()
    end,
})

awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")

--
-- ~/.config/awesome/rc.lua
--

-- Call LuaRocks if possible
pcall(require, "luarocks.loader")

-- Awesome default libraries
local gears = require("gears")
local awful = require("awful")

-- Awesome theming default library
local beautiful = require("beautiful")
local current_theme = "catppuccin"
beautiful.init(
  gears.filesystem.get_configuration_dir()
    .. "themes/"
    .. current_theme
    .. "/theme.lua"
)

require("awful.autofocus")
require("main.error-handling")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.spiral,
  awful.layout.suit.floating,
  -- awful.layout.suit.tile,
}

require("widgets.wibar")

root.keys(require("main.binds.global"))
root.buttons(require("main.binds.mouse"))

require("main.rules")
require("main.signals")

awful.spawn.with_shell(
  gears.filesystem.get_configuration_dir() .. "autostart.sh"
)

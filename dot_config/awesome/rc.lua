--
-- ~/.config/awesome/rc.lua
--
-- Extensions to try later:
-- Lain[Widgets]: https://github.com/lcpz/lain
-- Vicious[Widgets]: https://vicious.readthedocs.io/en/latest/index.html
-- Bling[Func.]: https://blingcorp.github.io/bling/#/README
-- Rubato[Anim.]: https://github.com/andOrlando/rubato
--
-- Guides & Wiki:
-- Official Wiki: https://awesomewm.org/apidoc/index.html
-- Arch Wiki: https://wiki.archlinux.org/title/Awesome
-- Nice Guide: https://epsi-rns.github.io/desktop/2019/06/17/awesome-modularized-main.html

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

require("main.error-handling")
require("awful.autofocus")

-- Layouts to be used. Order matters.
awful.layout.layouts = {
  awful.layout.suit.spiral,
  awful.layout.suit.floating,
}

require("widgets.wibar")

root.keys(require("binds.global"))
root.buttons(require("binds.mouse"))

require("main.rules")
require("main.signals")

awful.spawn.with_shell(
  gears.filesystem.get_configuration_dir() .. "autorun.sh"
)

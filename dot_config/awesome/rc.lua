--
-- ~/.config/awesome/rc.lua
--

-- === Extensions to try later ===
-- Lain[Widgets]:     https://github.com/lcpz/lain
-- Vicious[Widgets]:  https://vicious.readthedocs.io/en/latest/index.html
-- Bling[Func.]:      https://blingcorp.github.io/bling/#/README
-- Rubato[Anim.]:     https://github.com/andOrlando/rubato

-- === Guides & Wiki ===
-- Official Wiki:     https://awesomewm.org/apidoc/index.html
-- Arch Wiki:         https://wiki.archlinux.org/title/Awesome
-- Nice Guide:        https://epsi-rns.github.io/desktop/2019/06/17/awesome-modularized-main.html
-- Example Theme:     https://github.com/Relz/awesome-wm-theme

pcall(require, "luarocks.loader")

-- Default libraries
local gears = require("gears")
local awful = require("awful")

-- Theming
local beautiful = require("beautiful")
local current_theme = "catppuccin"
beautiful.init(
    gears.filesystem.get_configuration_dir()
    .. "themes/"
    .. current_theme
    .. "/theme.lua"
)

root.keys(require("binds.global-keys"))
root.buttons(require("binds.global-buttons"))

require("awful.autofocus")
require("main.error-handling")
require("main.rules")
require("main.signals")
require("main.keygrabber")

require("widgets.wibar")

awful.spawn.with_shell(
    gears.filesystem.get_configuration_dir() .. "autostart.sh"
)

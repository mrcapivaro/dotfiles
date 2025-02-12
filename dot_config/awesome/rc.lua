-- Ensure that LuaRocks libraries can be called.
pcall(require, "luarocks.loader")

require("main.errors")
require("main.global-keybinds")
require("main.clients")
require("main.theming")
require("main.after")

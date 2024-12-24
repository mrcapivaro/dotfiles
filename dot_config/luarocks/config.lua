-- ~/.config/luarocks/config.lua

-- https://www.reddit.com/r/lua/comments/18yci9m/luarocks_how_do_i_change_the_installation/
-- https://github.com/luarocks/luarocks/wiki/Config-file-format

local_by_default = true
-- lua_interpreter = "lua5.3"

rocks_trees = {
    {
        name = "user",
        root = home .. "/.local/share/luarocks",
    },

    {
        name = "system",
        root = "/usr",
    },
}

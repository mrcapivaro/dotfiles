---------------------------------------------------------------------------
--- Helper functions
--
-- This module provides functions that can help with the configuration of the
-- Awesome Window Manager.
--
-- @author Mister Capivaro &lt;mrcapivaro@gmail.com&gt;
-- @copyright 2024 Mister Capivaro
-- @module modules.utils
---------------------------------------------------------------------------

local M = {}

local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
-- local naughty = require("naughty")

-- utils.populate_beautiful(prefix, t):
--
-- Recursively assign values from a given table to the beautiful module using
-- the keys from the given table by joining the keys as strings.
--
-- @class function
-- @name recursive_assign
-- @param prefix The prefix commonly used by beautiful modules keys.
-- @param t A table containing the structured assignment of the module keys.
-- @return nil
M.populate_beautiful = function(prefix, t)
    for key, value in pairs(t) do
        local real_key
        if prefix ~= nil and prefix ~= "" then
            real_key = prefix .. "_" .. key
        else
            real_key = key
        end

        local value_type = type(value)

        if key == "font" and value_type == "table" then
            local font = string.format(
                "%s %s %s",
                value.name,
                value.weight or "Regular",
                value.size or 10
            )
            beautiful[real_key] = font
        elseif value_type == "table" then
            M.populate_beautiful(real_key, value)
        elseif key == "itself" then
            beautiful[prefix] = value
        elseif value ~= nil then
            beautiful[real_key] = value
        end
    end
end

M.sed = function(file, match, replace)
    local regex = "s/" .. match .. "/" .. replace .. "/"
    local cmd = 'sed -i ' .. '"' .. regex .. '"' .. ' ' .. '"' .. file .. '"'
    awful.spawn.with_shell(cmd)
end

M.toggle_colorscheme = function()
    -- toggle logic
    local curr = beautiful.colorscheme
    local dark = beautiful.colorscheme_dark
    local new = curr == dark and "light" or "dark"

    M.sed(
        gears.filesystem.get_configuration_dir() .. "rc.lua",
        "\\(^beautiful.colorscheme = beautiful.colorscheme_\\).*",
        "\\1" .. new
    )
end

---@param cmd_table table
M.safe_table_run = function(cmd_table)
    local cmd_string = table.concat(cmd_table, " ")

    -- Run the given cmd only if it's not already running.
    local cmd = "! pgrep -f '" .. cmd_table[1] .. "' && " .. cmd_string .. " &"

    awful.spawn.with_shell(cmd)
end

---@param cmd table
M.table_shell = function(cmd)
    awful.spawn.with_shell(table.concat(cmd, " "))
end

return M

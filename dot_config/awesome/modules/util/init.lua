local M = {}

local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

---Recursively assign values from a given table to the beautiful module using
---the keys from the given table by joining the keys as strings.
---@param prefix string
---@param t table
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
        elseif key == "itself" or type(key) == "number" then
            beautiful[prefix] = value
        elseif value ~= nil then
            beautiful[real_key] = value
        end
    end
end

---Wrapper around the 'sed' shell command.
---@param file_path string
---@param match string
---@param replace string
M.sed = function(file_path, match, replace)
    local regex = "s/" .. match .. "/" .. replace .. "/"
    local cmd = "sed -i "
        .. '"'
        .. regex
        .. '"'
        .. " "
        .. '"'
        .. file_path
        .. '"'
    awful.spawn.with_shell(cmd)
end

---Change the value of the beautiful.colorscheme variable according to it's
---current value and the values of beautiful.colorscheme_{dark,light}.
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

M.print = function(message)
    if type(message) ~= "string" then
        message = tostring(message)
    end
    naughty.notify({
        title = "Message:",
        text = message
    })
end

M.string = {}

M.string.split = function(instr, sep)
    local result = {}
    local matches = string.gmatch(instr, string.format("[^%s]+", sep))
    for m in matches do
        table.insert(result, m)
    end
    return result
end

M.x11 = {}

-- awesome.xkb_set_layout_group uses the module operator internally, therefore
-- it is not needed to actually calculate anything for this. Adding one sets
-- the next layout and subtracting one selects the previous keyboard layout.
--
-- If it was needed to do this manually, it could be done by using a split
-- string to table function in the groups string using "+" as the sepator and
-- then counting how many of the groups are actually layouts. Then, just add one
-- or subtract one from the current index and calculate final_index % total.
M.x11.next_layout = function()
    local current = awesome.xkb_get_layout_group()
    awesome.xkb_set_layout_group(current + 1)
end

return M

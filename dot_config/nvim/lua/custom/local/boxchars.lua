local M = { mt = {} }

M.chars = {
    single = {
        vertical = "│",
        horizontal = "─",
        top_left = "┌",
        top_right = "┐",
        bottom_left = "└",
        bottom_right = "┘",

        rounded = {
            top_left = "╭",
            top_right = "╮",
            bottom_left = "╰",
            bottom_right = "╯",
        },

        composite = {
            center = "┼",
            right = "├",
            left = "┤",
            top = "┴",
            bottom = "┬",
        },
    },
}

M.direction_from_key = {
    h = "left",
    j = "down",
    k = "up",
    l = "right",
}

M.directions_from_keys = function(keys_str)
    local directions = {
        left = 0,
        down = 0,
        up = 0,
        right = 0
    }
    for idx = 1, #keys_str do
        local key = string.char(keys_str:byte(idx))
        local direction = M.direction_from_key[key]
        assert(direction ~= nil, "Tried to index with non existant key!")
        directions[direction] = 1
    end
    return directions
end

M.primitive_from_directions = function(directions)
    local primitive = string.format(
        "%s%s%s%s",
        directions.left,
        directions.down,
        directions.up,
        directions.right
    )
    return primitive
end

M.char_from_primitive = {
    ["0110"] = "│",
    ["1001"] = "─",
    ["0101"] = "┌",
    ["1100"] = "┐",
    ["0011"] = "└",
    ["1010"] = "┘",
    ["0111"] = "├",
    ["1110"] = "┤",
    ["1011"] = "┴",
    ["1101"] = "┬",
    ["1111"] = "┼",
}

M.mt.__index = function(_, keys_str)
    local directions = M.directions_from_keys(keys_str)
    local primitive = M.primitive_from_directions(directions)
    return M.char_from_primitive[primitive]
end

setmetatable(M, M.mt)

return M

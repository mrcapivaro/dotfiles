local M = { mt = {} }

M.options = {
    path = "",
    geometry = { width = 0, height = 0 },
    colors = { fill = "", outline = "", background = {} },
}

return setmetatable(M, M.mt)

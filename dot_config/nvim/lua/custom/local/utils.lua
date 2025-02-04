local utils = {}

utils.map = function(args)
    local mode = args.mode
    local rhs = args.rhs

    local lhs_list = type(args.lhs) == "table" and args.lhs or { args.lhs }

    local default_options = { silent = true, expr = false, nowait = false }
    local options =
        vim.tbl_deep_extend("force", default_options, args.options or {})
    if args.desc then
        options.desc = args.desc
    end

    for _, lhs in ipairs(lhs_list) do
        vim.keymap.set(mode, lhs, rhs, options)
    end
end

utils.cmd = function(str)
    return "<CMD>" .. str .. "<CR>"
end

return utils

local none_ls = require("null-ls")
local formatters = require("ensure-installed").none_ls.formatters
-- local linters = require("ensure-installed").none_ls.linters

local sources = {}
for _, formatter in ipairs(formatters) do
  table.insert(sources, none_ls.builtins.formatting[formatter])
end
-- for _, linter in ipairs(linters) do
--   table.insert(sources, none_ls.builtins.diagnostics[linter])
-- end

none_ls.setup({ sources = sources, })

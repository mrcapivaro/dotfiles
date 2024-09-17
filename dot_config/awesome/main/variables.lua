local M = {}

M.terminal = "kitty"
M.browser = "firefox"
M.editor = os.getenv("EDITOR") or "vi"
M.modkey = "Mod4"
-- M.get = function(...)
--   return {
--     terminal = "kitty",
--     browser = "firefox",
--     modkey = "Mod4",
--     editor = os.getenv("EDITOR") or "vi",
--   }
-- end

return M
-- return setmetatable({}, {
--   __call = function(_, ...)
--     M.get(...)
--   end,
-- })

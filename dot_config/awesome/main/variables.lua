local M = {}

M.terminal = "kitty"
M.browser = "firefox"
M.editor = os.getenv("EDITOR") or "vi"
M.keymap = "us"
M.modkey = "Mod4"

return M

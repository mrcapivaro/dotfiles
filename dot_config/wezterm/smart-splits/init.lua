local w = require("wezterm")
local M = {}

M.is_vim = function(pane)
  return pane:get_user_vars().IS_NVIM == "true"
end

M.direction_keys = {
  h = "Left",
  j = "Down",
  k = "Up",
  l = "Right",
}

M.split_nav = function(resize_or_move, key)
  return {
    key = key,
    mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL",
    action = w.action_callback(function(win, pane)
      if M.is_vim(pane) then
        win:perform_action({
          SendKey = {
            key = key,
            mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL",
          },
        }, pane)
      else
        if resize_or_move == "resize" then
          win:perform_action(
            { AdjustPaneSize = { M.direction_keys[key], 3 } },
            pane
          )
        else
          win:perform_action(
            { ActivatePaneDirection = M.direction_keys[key] },
            pane
          )
        end
      end
    end),
  }
end

return M

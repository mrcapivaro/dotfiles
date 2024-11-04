local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder() then
    config = wezterm.config_builder()
end

-- [ Machine OS Specific ] --
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

if is_windows then
    config.default_prog = { "pwsh", "-NoLogo" }
    config.integrated_title_button_style = "Windows"
    config.window_decorations = "INTEGRATED_BUTTONS" .. "|" .. "RESIZE"
    config.hide_tab_bar_if_only_one_tab = true
else
    config.default_prog = { "fish" }
    config.window_decorations = "RESIZE"
    config.hide_tab_bar_if_only_one_tab = true
end

-- Fonts
config.font = wezterm.font("IosevkaCapy Nerd Font", { weight = "Medium" })
config.font_size = 11

-- Theme
local dark_theme = "Catppuccin Mocha"
local light_theme = "Catppuccin Latte"
local current_theme = dark_theme
config.color_scheme = current_theme

-- Tabs and Window
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1.00
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

config.window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
}

-- [ Keybinds ] --

-- Utils
local is_vim = function(pane)
    return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
    h = "Left",
    j = "Down",
    k = "Up",
    l = "Right",
}

local split_nav = function(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL",
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = {
                        key = key,
                        mods = resize_or_move == "resize" and "CTRL|SHIFT"
                            or "CTRL",
                    },
                }, pane)
            else
                if resize_or_move == "resize" then
                    win:perform_action(
                        { AdjustPaneSize = { direction_keys[key], 3 } },
                        pane
                    )
                else
                    win:perform_action(
                        { ActivatePaneDirection = direction_keys[key] },
                        pane
                    )
                end
            end
        end),
    }
end

config.disable_default_key_bindings = true
config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 500 }
config.keys = {
    {
        key = "Tab",
        mods = "CTRL",
        action = wezterm.action.ActivateTabRelative(1),
    },
    {
        key = "Tab",
        mods = "CTRL|SHIFT",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    {
        key = "t",
        mods = "CTRL|SHIFT",
        action = wezterm.action.SpawnTab("DefaultDomain"),
    },
    {
        key = "d",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = "q",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    {
        key = ",",
        mods = "LEADER",
        action = wezterm.action.SpawnCommandInNewTab({
            cwd = wezterm.config_dir,
            args = {
                "nvim",
                "wezterm.lua",
            },
        }),
    },
    {
        key = "p",
        mods = "LEADER",
        action = wezterm.action.ActivateCommandPalette,
    },
    {
        key = "t",
        mods = "LEADER",
        action = wezterm.action.SpawnCommandInNewTab({
            cwd = wezterm.config_dir,
            args = {
                "sed",
                "-i",
                "'/^local current_theme/c\\local current_theme = "
                    .. (current_theme == dark_theme and "light_theme" or "dark_theme")
                    .. "'",
                "wezterm.lua",
            },
        }),
    },
    {
        key = "|",
        mods = "LEADER|SHIFT",
        action = wezterm.action.SplitHorizontal({
            domain = "CurrentPaneDomain",
        }),
    },
    {
        key = "\\",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
        key = "x",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = "c",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    {
        key = "n",
        mods = "LEADER",
        action = wezterm.action.SpawnTab("DefaultDomain"),
    },
    {
        key = "o",
        mods = "CTRL",
        action = wezterm.action.SendString("clear\r"),
    },
    split_nav("move", "h"),
    split_nav("move", "j"),
    split_nav("move", "k"),
    split_nav("move", "l"),
    split_nav("resize", "h"),
    split_nav("resize", "j"),
    split_nav("resize", "k"),
    split_nav("resize", "l"),
}

return config

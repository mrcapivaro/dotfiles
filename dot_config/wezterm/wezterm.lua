local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Shell used
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"
if is_windows then
    config.default_prog = { "pwsh", "-NoLogo" }
else
    -- currently using zsh
    -- config.default_prog = { "fish" }
end

-- 120 guarantees a smoother experience even on 60hz monitors.
config.max_fps = 120

--{{{1 Appearance

--{{{2Fonts
config.font = wezterm.font("IosevkaCapy Nerd Font", { weight = "Medium" })
config.font_size = 11
--2}}}

--{{{2 Theme
local dark_theme = "Catppuccin Mocha"
local light_theme = "Catppuccin Latte"
local current_theme = "Catppuccin Mocha"
config.color_scheme = current_theme
--2}}}

--{{{2 Tabs and Window
-- Window
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1.00
config.window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
}
if is_windows then
    config.integrated_title_button_style = "Windows"
    config.window_decorations = "INTEGRATED_BUTTONS" .. "|" .. "RESIZE"
else
    config.window_decorations = "RESIZE"
end
-- Tabs
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = true
--2}}}

--1}}}

--{{{1 Keybinds
config.disable_default_key_bindings = true

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 500 }

config.keys = {
    -- Copy & Paste
    {
        key = "c",
        mods = "CTRL|SHIFT",
        action = wezterm.action.CopyTo("ClipboardAndPrimarySelection"),
    },
    {
        key = "v",
        mods = "CTRL|SHIFT",
        action = wezterm.action.PasteFrom("Clipboard"),
    },

    --{{{2 Tabs
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
        mods = "LEADER",
        action = wezterm.action.SpawnTab("DefaultDomain"),
    },
    {
        key = "q",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentTab({ confirm = false }),
    },
    --2}}}

    --{{{2 Panes
    {
        key = "d",
        mods = "LEADER",
        action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },
    {
        key = "'",
        mods = "LEADER",
        action = wezterm.action.SplitHorizontal({
            domain = "CurrentPaneDomain",
        }),
    },
    {
        key = ";",
        mods = "LEADER",
        action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    --2}}}

    --{{{2 Other
    {
        key = "o",
        mods = "CTRL",
        action = wezterm.action.SendString("clear\r"),
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
        key = "\\",
        mods = "LEADER",
        action = wezterm.action.SpawnCommandInNewTab({
            cwd = wezterm.config_dir,
            args = {
                "sed",
                "-i",
                's/\\(^local current_theme = \\).*/\\1"'
                    .. (current_theme == dark_theme and light_theme or dark_theme)
                    .. '"/',
                "wezterm.lua",
            },
        }),
    },
    --2}}}
}
--1}}}

--{{{1 Vim Integration
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

table.insert(config.keys, split_nav("move", "h"))
table.insert(config.keys, split_nav("move", "j"))
table.insert(config.keys, split_nav("move", "k"))
table.insert(config.keys, split_nav("move", "l"))
table.insert(config.keys, split_nav("resize", "h"))
table.insert(config.keys, split_nav("resize", "j"))
table.insert(config.keys, split_nav("resize", "k"))
table.insert(config.keys, split_nav("resize", "l"))
--1}}}

return config

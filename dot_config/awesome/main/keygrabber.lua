local awful = require("awful")

awful.keygrabber({
    keybindings = {
        awful.key({
            modifiers = { "Mod1" },
            key = "Tab",
            on_press = awful.client.focus.history.select_previous,
            -- { description = "Alt Tab", group = "alt tab" },
        }),
        -- awful.key({
        --     { "Mod1",                           "Shift" },
        --     "Tab",
        --     awful.client.focus.history.select_next,
        --     { description = "Alt Tab previous", group = "alt tab" },
        -- }),
    },
    stop_key = "Mod1",
    stop_event = "release",
    start_callback = awful.client.focus.history.disable_tracking,
    stop_callback = awful.client.focus.history.enable_tracking,
    export_keybindings = true,
})

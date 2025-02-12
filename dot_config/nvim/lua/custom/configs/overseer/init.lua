local overseer = require("overseer")

overseer.setup({
    templates = { "builtin", "template" },

    template_dirs = {
        "overseer.template",
        "custom.configs.overseer",
    },

    task_list = {
        default_detail = 1,
        bindings = {
            ["q"] = "Close",
        },
    },

    form = { border = "single" },
    confirm = { border = "single" },
    task_win = { border = "single" },
    help_win = { border = "single" },
})

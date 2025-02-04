local telescope = require("telescope")
local actions = require("telescope.actions")
local bc = require("custom.local.boxchars")
local NuiLayout = require("nui.layout")
local NuiPopup = require("nui.popup")
local TSLayout = require("telescope.pickers.layout")

local opts = {}
opts.defaults = {
    -- Top to bottom instead of bottom to top.
    sorting_strategy = "ascending",
    mappings = {
        n = {
            ["<Left>"] = actions.close,
            ["<Right>"] = actions.select_default,
        },
    },
    vimgrep_arguments = {
        "rg",
        "--hidden",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
    },
}

-- Default Picker Layout {{{

opts.defaults.layout_strategy = "flex"
opts.defaults.layout_config = {
    horizontal = {
        size = {
            width = "90%",
            height = "70%",
        },
    },
    vertical = {
        size = {
            width = "90%",
            height = "90%",
        },
    },
}

local borders = {
    prompt = {
        top_left = bc.jl,
        top = bc.hl,
        top_right = bc.jh,
        right = bc.jk,
        left = bc.jk,
        bottom_right = bc.kh,
        bottom = bc.hl,
        bottom_left = bc.kl,
    },
    prompt_patch = {
        minimal = {
            bottom_right = "",
            bottom = "",
            bottom_left = "",
        },
        horizontal = {
            top_right = bc.hjl,
            bottom_right = "",
            bottom = "",
            bottom_left = "",
        },
        vertical = {
            bottom_right = "",
            bottom = "",
            bottom_left = "",
        },
    },
    results = {
        top_left = bc.hj,
        top = bc.hl,
        top_right = bc.lj,
        right = bc.jk,
        left = bc.jk,
        bottom_right = bc.kh,
        bottom = bc.hl,
        bottom_left = bc.kl,
    },
    results_patch = {
        minimal = {
            top_left = bc.jkl,
            top_right = bc.jkh,
        },
        horizontal = {
            top_left = bc.jkl,
            top_right = bc.jkh,
            bottom_right = bc.hlk,
        },
        vertical = {
            top_left = bc.jkl,
            top_right = bc.jkh,
            bottom_right = "",
            bottom = "",
            bottom_left = "",
        },
    },
    preview = {
        top_left = bc.hj,
        top = bc.hl,
        top_right = bc.jh,
        right = bc.jk,
        left = bc.jk,
        bottom_right = bc.kh,
        bottom = bc.hl,
        bottom_left = bc.kl,
    },
    preview_patch = {
        horizontal = {
            top_left = "",
            left = "",
            bottom_left = "",
        },
        vertical = {
            top_left = bc.jkl,
            top_right = bc.jkh,
        },
    },
}

local function NuiTSPopupWrapper(options)
    -- Surround the popup title with spaces.
    if options.border.text.top then
        options.border.text.top = string.format(" %s ", options.border.text.top)
    end

    local popup = NuiPopup(options)
    function popup.border:change_title(title)
        popup.border.set_text(popup.border, "top", title)
    end

    return TSLayout.Window(popup)
end

opts.defaults.create_layout = function(picker)
    local results = NuiTSPopupWrapper({
        focusable = false,
        border = {
            style = borders.results,
            text = {
                top = picker.results_title,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
    })

    local prompt = NuiTSPopupWrapper({
        enter = true,
        border = {
            style = borders.prompt,
            text = {
                top = picker.prompt_title,
                top_align = "center",
            },
        },
        win_options = {
            -- winhighlight = "Normal:Normal",
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
    })

    local preview = NuiTSPopupWrapper({
        focusable = false,
        border = {
            style = borders.preview,
            text = {
                top = picker.preview_title,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
    })

    local box_by_kind = {
        vertical = NuiLayout.Box({
            NuiLayout.Box(prompt, { size = 3 }),
            NuiLayout.Box(results, { grow = 1 }),
            NuiLayout.Box(preview, { grow = 1 }),
        }, { dir = "col" }),

        horizontal = NuiLayout.Box({
            NuiLayout.Box({
                NuiLayout.Box(prompt, { size = 3 }),
                NuiLayout.Box(results, { grow = 1 }),
            }, { grow = 1, dir = "col" }),
            NuiLayout.Box(preview, { grow = 1 }),
        }, { dir = "row" }),

        minimal = NuiLayout.Box({
            NuiLayout.Box(prompt, { size = 3 }),
            NuiLayout.Box(results, { grow = 1 }),
        }, { dir = "col" }),
    }

    local function get_box()
        local strategy = picker.layout_strategy
        if strategy == "vertical" or strategy == "horizontal" then
            return box_by_kind[strategy], strategy
        end

        local height, width = vim.o.lines, vim.o.columns
        local box_kind = "horizontal"
        if width < 100 then
            box_kind = "vertical"
            if height < 40 then
                box_kind = "minimal"
            end
        end
        return box_by_kind[box_kind], box_kind
    end

    local function prepare_layout_parts(layout, box_type)
        layout.results = results
        results.border:set_style(borders.results_patch[box_type])

        layout.prompt = prompt
        prompt.border:set_style(borders.prompt_patch[box_type])

        if box_type == "minimal" then
            layout.preview = nil
        else
            layout.preview = preview
            preview.border:set_style(borders.preview_patch[box_type])
        end
    end

    local function get_layout_size(box_kind)
        return picker.layout_config[box_kind == "minimal" and "vertical" or box_kind].size
    end

    local box, box_kind = get_box()
    local layout = NuiLayout({
        relative = "editor",
        position = "50%",
        size = get_layout_size(box_kind),
    }, box)

    layout.picker = picker
    prepare_layout_parts(layout, box_kind)

    local layout_update = layout.update
    function layout:update()
        local box, box_kind = get_box()
        prepare_layout_parts(layout, box_kind)
        layout_update(self, { size = get_layout_size(box_kind) }, box)
    end

    return TSLayout(layout)
end

-- }}}

opts.pickers = {}

opts.pickers.buffers = {
    initial_mode = "normal",
    sort_mru = true,
    mappings = {
        n = {
            ["d"] = "delete_buffer",
            ["dd"] = "delete_buffer",
        },
    },
}

telescope.setup(opts)

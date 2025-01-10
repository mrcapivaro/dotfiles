local telescope = require("telescope")
local bc        = require("custom.local.boxchars")

local opts    = {}
opts.defaults = {}

-- Layout {{{

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

opts.defaults.create_layout = function(picker)
    local TSLayout = require("telescope.pickers.layout")
    local NuiLayout = require("nui.layout")
    local NuiPopup = require("nui.popup")

    local function make_popup(options)
        local popup = NuiPopup(options)
        function popup.border:change_title(title)
            popup.border.set_text(popup.border, "top", title)
        end

        return TSLayout.Window(popup)
    end

    local border = {
        results = {
            top_left = "",
            top = "",
            top_right = "",
            right = bc.jk,
            left = bc.jk,
            bottom_right = bc.hlk,
            bottom = bc.hl,
            bottom_left = bc.kl,
        },
        results_patch = {
            minimal = {
                top_left = bc.jl,
                top_right = bc.jh,
            },
            horizontal = {
                top_left = "",
                top_right = "",
            },
            vertical = {
                top_left = bc.jkl,
                top_right = bc.jkh,
            },
        },
        prompt = {
            top_left = bc.jl,
            top = bc.hl,
            top_right = bc.jh,
            right = bc.jk,
            left = bc.jk,
            bottom_right = bc.jkh,
            bottom = bc.hl,
            bottom_left = bc.jkl,
        },
        prompt_patch = {
            minimal = {
                bottom_right = bc.kh,
            },
            horizontal = {
                bottom_right = bc.jkh,
            },
            vertical = {
                bottom_right = bc.kh,
            },
        },
        preview = {
            top_left = bc.hlk,
            top = "",
            top_right = "",
            right = bc.jk,
            bottom_right = bc.kh,
            bottom = bc.hl,
            bottom_left = bc.kl,
            left = "",
        },
        preview_patch = {
            minimal = {},
            horizontal = {
                bottom = bc.hl,
                bottom_left = "",
                bottom_right = bc.kh,
                left = "",
                top_left = bc.hlk,
            },
            vertical = {
                bottom = "",
                bottom_left = "",
                bottom_right = "",
                left = bc.jk,
                top_left = bc.jl,
            },
        },
    }

    local results = make_popup({
        focusable = false,
        border = {
            style = border.results,
            text = {
                top = picker.results_title,
                top_align = "center",
            },
        },
        win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal,CursorLine:BlinkCmpDocCursorLine,Search:None",
        },
    })

    local prompt = make_popup({
        enter = true,
        border = {
            style = border.prompt,
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

    local preview = make_popup({
        focusable = false,
        border = {
            style = border.preview,
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
            NuiLayout.Box(prompt, { size = 3 }),
            NuiLayout.Box({
                NuiLayout.Box(results, { size = "50%" }),
                NuiLayout.Box(preview, { grow = 1 }),
            }, { grow = 1, dir = "row" }),
        }, { dir = "col" }),

        minimal = NuiLayout.Box({
            NuiLayout.Box(results, { grow = 1 }),
            NuiLayout.Box(prompt, { size = 3 }),
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
        results.border:set_style(border.results_patch[box_type])

        layout.prompt = prompt
        prompt.border:set_style(border.prompt_patch[box_type])

        if box_type == "minimal" then
            layout.preview = nil
        else
            layout.preview = preview
            preview.border:set_style(border.preview_patch[box_type])
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

telescope.setup(opts)

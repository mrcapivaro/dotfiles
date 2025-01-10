-- ~/.config/nvim/lua/keymaps.lua

-- Wrapper for 'vim.keymap.set' {{{

local map = function(args)
    local mode = args.modes or args.mode
    local lhs = args.lhs
    local rhs = args.rhs

    local default_options = { silent = true, expr = false, nowait = false }
    local options =
        vim.tbl_deep_extend("force", default_options, args.options or {})
    if args.desc then
        options.desc = args.desc
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

-- }}}
-- Quality of Life {{{

map({
    desc = "Quit without saving.",
    mode = "n",
    lhs = "<leader>q",
    rhs = "ZQ",
})

map({
    desc = "Escape and clear hlsearch.",
    modes = { "c", "n", "o", "v", "i" },
    lhs = "<esc>",
    rhs = "<cmd>noh<cr><esc>",
})

-- }}}
-- Execution of Code & Commands {{{

map({
    desc = "Run file with lua interpreter.",
    modes = "n",
    lhs = "<leader>xl",
    rhs = ":%lua<cr>",
})

map({
    desc = "Run selection with lua interpreter.",
    modes = "v",
    lhs = "<leader>xl",
    rhs = ":lua<cr>",
})

map({
    desc = "Run last ex command.",
    modes = { "n", "v" },
    lhs = "<leader>re",
    rhs = ":<Up><cr>",
})

-- }}}
-- Windows {{{

map({
    desc = "Write buffer changes.",
    modes = { "n", "v", "x", "i", "s" },
    lhs = "<C-s>",
    rhs = "<cmd>w<cr>",
})

map({
    desc = "Write buffer changes.",
    modes = { "n", "v", "x", "s" },
    lhs = "<leader>ww",
    rhs = "<cmd>w<cr>",
})

map({
    desc = "Vertical window split.",
    modes = { "n", "v" },
    lhs = "<leader>wv",
    rhs = "<cmd>vertical split<cr>",
})

map({
    desc = "Horizontal window split.",
    modes = { "n", "v" },
    lhs = "<leader>ws",
    rhs = "<cmd>horizontal split<cr>",
})

-- }}}
-- Text Editing {{{

-- Move lines of code with visual mode
map({
    modes = "v",
    lhs = "<S-k>",
    rhs = "<cmd>m+1<cr>vv",
})

map({
    modes = "v",
    lhs = "<S-j>",
    rhs = "<cmd>m-2<cr>vv",
})

map({
    modes = "x",
    lhs = "<S-k>",
    rhs = ":m '<-2<cr>gv=gv",

})

map({
    modes = "x",
    lhs = "<S-j>",
    rhs = ":m '>+1<cr>gv=gv",

})

-- Better Indent
map({
    modes = "x",
    lhs = ">",
    rhs = ">gv",

})

map({
    modes = "x",
    lhs = "<",
    rhs = "<gv",

    })

-- }}}
-- Movement {{{

map({
    mode = "n",
    lhs = "<C-u>",
    rhs = "<C-u>zz",
})

map({
    mode = "n",
    lhs = "<C-d>",
    rhs = "<C-d>zz",
})

-- }}}
-- Buffers {{{

map({
    desc = "Next buffer.",
    modes = { "n", "v" },
    lhs = "gs",
    rhs = "<cmd>bn<cr>",
})

map({
    desc = "Previous buffer.",
    modes = { "n", "v" },
    lhs = "gS",
    rhs = "<cmd>bp<cr>",
})

map({
    desc = "Close buffer.",
    modes = { "n", "v" },
    lhs = "<leader>bd",
    rhs = "<cmd>bd<cr>",
})

map({
    desc = "Force close buffer.",
    modes = { "n", "v" },
    lhs = "<leader>bD",
    rhs = "<cmd>bd!<cr>",
})

-- }}}
-- Folding {{{

map({
    desc = "Toggle folding alias.",
    modes = { "n", "v", "x" },
    lhs = "<tab>",
    rhs = "za",
})

-- }}}

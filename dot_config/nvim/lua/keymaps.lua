-- https://github.com/ibhagwan/vim-cheatsheet

local utils = require("custom.local.utils")
local map = utils.map
local cmd = utils.cmd

-- Quit Commands {{{

map({
    desc = "Quit all.",
    mode = "n",
    lhs  = { "<C-q>q", "<C-q><C-q>" },
    rhs  = "ZQ",
})

map({
    desc = "Quit window.",
    mode = "n",
    lhs  = { "<C-q>w", "<C-q><C-w>" },
    rhs  = "<C-w>q",
})

map({
    desc = "Quit buffer.",
    mode = "n",
    lhs  = { "<C-q>b", "<C-q><C-b>" },
    rhs  = cmd("bd"),
})

-- }}}
-- Marks {{{

map({
    desc = "Move to mark",
    mode = "n",
    lhs = "M",
    rhs = "`",
})

map({
    desc = "Move to position before jump",
    mode = "n",
    lhs = "MM",
    rhs = "``",
})

-- }}}
-- Execution of code {{{

map({
    mode = { "n", "v" },
    lhs = "<space>re",
    rhs = ":<UP><CR>",
})

map({
    mode = "n",
    lhs = "<space>xl",
    rhs = ":%lua<cr>",
})

map({
    mode = "v",
    lhs = "<space>xl",
    rhs = ":lua<cr>",
})

-- }}}
-- Quality of Life {{{

map({
    desc = "Escape and clear hlsearch.",
    mode = { "c", "n", "o", "v", "i", "t" },
    lhs = "<esc>",
    rhs = "<cmd>noh<cr><esc>",
})

-- }}}
-- Text Editing {{{

-- Move lines of code with visual mod
map({
    mode = "v",
    lhs = "<S-k>",
    rhs = "<cmd>m+1<cr>vv",
})

map({
    mode = "v",
    lhs = "<S-j>",
    rhs = "<cmd>m-2<cr>vv",
})

map({
    mode = "x",
    lhs = "<S-k>",
    rhs = ":m '<-2<cr>gv=gv",
})

map({
    mode = "x",
    lhs = "<S-j>",
    rhs = ":m '>+1<cr>gv=gv",

})

-- Better Indent
map({
    mode = "x",
    lhs = ">",
    rhs = ">gv",

})

map({
    mode = "x",
    lhs = "<",
    rhs = "<gv",
})

local symbols_list = {
    { "'", "'" },
    { '"', '"' },
    { "{", "}" },
    { "[", "]" },
    { "(", ")" },
}

-- Surround selection with symbol
for _, symbols in ipairs(symbols_list) do
    local lsymbol, rsymbol = symbols[1], symbols[2]

    map({
        desc = "Surround selection with " .. lsymbol .. rsymbol,
        mode = "v",
        lhs = "s" .. lsymbol,
        rhs = "c" .. lsymbol .. rsymbol .. "\27hp",
    })

    if lsymbol ~= rsymbol then
        map({
            desc = "Surround selection with " .. lsymbol .. rsymbol,
            mode = "v",
            lhs = "s" .. rsymbol,
            rhs = "c" .. lsymbol .. rsymbol .. "\27hp",
        })
    end
end

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
    desc = "Write buffer changes.",
    mode = { "n", "v", "x", "s" },
    lhs = "<space>s",
    rhs = "<cmd>w<cr>",
})

map({
    mode = "n",
    lhs = "gn",
    rhs = cmd("bnext"),
})

map({
    mode = "n",
    lhs = "gp",
    rhs = cmd("bprevious"),
})

map({
    desc = "Close buffer.",
    mode = { "n", "v" },
    lhs = "<space>bd",
    rhs = "<cmd>bd<cr>",
})

map({
    desc = "Force close buffer.",
    mode = { "n", "v" },
    lhs = "<space>bD",
    rhs = "<cmd>bd!<cr>",
})

-- }}}
-- Folding {{{

map({
    desc = "Toggle folding alias.",
    mode = { "n", "v", "x" },
    lhs = "<tab>",
    rhs = "za",
})

-- }}}

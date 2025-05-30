-- ~/.config/nvim/lua/keymaps.lua

-- Preamble {{{1

local cmd = function(str)
    return "<CMD>" .. str .. "<CR>"
end

local map = function(args)
    -- Unpack arguments.
    local mode = type(args.mode) == "table" and args.mode or { args.mode }
    local options = vim.tbl_deep_extend(
        "force",
        -- Default options for keymaps.
        {
            -- desc = args.desc,
            silent = true,
            expr = false,
            nowait = false
        },
        args.options or {}
    )

    -- TODO: Implement type check for arguments.

    -- If there is not a lhs argument, then it is supposed for there to be
    -- an array of tables containing pairs of lhs and rhs strings or
    -- commands.
    for _, tbl in ipairs(args) do
        vim.keymap.set(mode, tbl[1], tbl[2], options)
    end
end

local normal = "n"
local visual = "v"
local insert = "i"
local insert_completion = "ic"
local operator = "no"
local replace = "R"
local all = { normal, visual, insert }
local non_insert = { normal, visual }

-- 1}}}

-- Quality of Life {{{

map({
    mode = "n",
    { "<space>q", "ZQ" },
})

map({
    desc = "Escape and clear hlsearch.",
    mode = { "c", "n", "o", "v", "i", "t" },
    { "<esc>", "<cmd>noh<cr><esc>" },
})

-- }}}
-- Remap Window Commands to Leader Key {{{

map({
    mode = "n",
    { "<space>wd", "<C-w>q" },
    { "<space>ws", "<C-w>s" },
    { "<space>wv", "<C-w>v" },
    { "<space>wo", "<C-w>w" },
    { "<space>wh", "<C-w>h" },
    { "<space>wj", "<C-w>j" },
    { "<space>wk", "<C-w>k" },
    { "<space>wl", "<C-w>l" },
})

-- }}}
-- Marks {{{

map({
    desc = "Move to mark",
    mode = "n",
    { "M", "`" },
})

map({
    desc = "Move to position before jump",
    mode = "n",
    { "MM", "``" },
})

-- }}}
-- Execution of code {{{

map({
    mode = { "n", "v" },
    { "<space>re", ":<UP><CR>" },
})

map({
    mode = "n",
    { "<space>xl", ":%lua<cr>" },
})

map({
    mode = "v",
    { "<space>xl", ":lua<cr>" },
})

-- }}}
-- Text Editing {{{

map({
    mode = { "n", "v", "x" },
    { "xc", "gc" },
    { "xi", "gq" },
})

-- Move lines of code with visual mod
map({
    mode = "v",
    { "<S-k>", "<cmd>m+1<cr>vv" },
})

map({
    mode = "v",
    { "<S-j>", "<cmd>m-2<cr>vv" },
})

map({
    mode = "x",
    { "<S-k>", ":m '<-2<cr>gv=gv" },
})

map({
    mode = "x",
    { "<S-j>", ":m '>+1<cr>gv=gv" },
})

-- Better Indent
map({
    mode = "x",
    { ">", ">gv" },
})

map({
    mode = "x",
    { "<", "<gv" },
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
        { "s" .. lsymbol, "c" .. lsymbol .. rsymbol .. "\27hp" },
    })

    if lsymbol ~= rsymbol then
        map({
            desc = "Surround selection with " .. lsymbol .. rsymbol,
            mode = "v",
            { "s" .. rsymbol, "c" .. lsymbol .. rsymbol .. "\27hp" },
        })
    end
end

-- }}}
-- Movement {{{

map({
    mode = "n",
    { "<C-u>", "<C-u>zz" },
})

map({
    mode = "n",
    { "<C-d>", "<C-d>zz" },
})

-- }}}
-- Buffers {{{

map({
    desc = "Write buffer changes.",
    mode = { "n", "v", "x", "s" },
    { "<space>s", "<cmd>w<cr>" },
})

map({
    desc = "Close buffer.",
    mode = { "n", "v" },
    { "<space>jd", "<cmd>bd<cr>" },
})

map({
    desc = "Force close buffer.",
    mode = { "n", "v" },
    { "<space>jD", "<cmd>bd!<cr>" },
})

map({
    mode = "n",
    { "L", cmd("bnext") },
})

map({
    mode = "n",
    { "H", cmd("bprevious") },
})

-- }}}
-- Folding {{{

map({
    desc = "Toggle folding alias.",
    mode = { "n", "v", "x" },
    { "<tab>", "za" },
})

-- }}}

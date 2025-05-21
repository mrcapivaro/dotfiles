local treesitter_configs = require("nvim-treesitter.configs")
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- Setup Treesitter {{{

-- Use git instead of curl.
require("nvim-treesitter.install").prefer_git = true

treesitter_configs.setup({
    ensure_installed = {
        -- vim --
        "vim",
        "vimdoc",
        "query",
        "regex",
        -- lua --
        "lua",
        "luadoc",
        "luap",
        -- shell --
        "bash",
        -- notes --
        "markdown",
        "markdown_inline",
        "latex", -- requires tree-sitter-cli installed
        -- web --
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        -- other --
        "c",
        "cpp",
        "rust",
        "go",
        "python",
        -- config --
        "toml",
        "yaml",
        "ini",
        "json",
    },
    auto_install = true,
    ignore_install = {},
    indent = {
        enable = true,
        disable = { "html" },
    },
    -- incremental_selection = {
    --     enable = false,
    --     keymaps = {
    --         -- set to `false` to disable one of the mappings
    --         init_selection = false, -- gnn
    --         node_incremental = "grn",
    --         scope_incremental = "grc",
    --         node_decremental = "grm",
    --     },
    -- },
    highlight = {
        enable = true,
        disable = function(_, buf)
            local max_filesize = 2000 * 1024
            local ok, stats =
                pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        -- additional_vim_regex_highlighting = false,
    },
})

-- }}}

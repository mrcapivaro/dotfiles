return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = {
      enable = true,
      disable = { "html" },
    },
    ensure_installed = {
      -- vim --
      "vim",
      "vimdoc",
      "query",
      -- lua --
      "lua",
      "luadoc",
      "luap",
      -- shell
      "bash",
      -- notes --
      "markdown",
      "markdown_inline",
      -- "norg",
      -- "org",
      -- web dev --
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
    -- incremental_selection = {
    --   enable = true,
    --   keymaps = {},
    -- },
  },
  config = function(_, opts)
    -- -- Don't reinstall parsers again everytime
    -- if type(opts.ensure_installed) == "table" then
    --   local added = {}
    --   opts.ensure_installed = vim.tbl_filter(function(lang)
    --     if added[lang] then
    --       return false
    --     end
    --     added[lang] = true
    --     return true
    --   end, opts.ensure_installed)
    -- end
    -- Setup Treesitter
    require("nvim-treesitter.configs").setup(opts)
  end,
}

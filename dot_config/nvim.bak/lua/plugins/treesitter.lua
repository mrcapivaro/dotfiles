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
    require("nvim-treesitter.configs").setup(opts)
  end,
}

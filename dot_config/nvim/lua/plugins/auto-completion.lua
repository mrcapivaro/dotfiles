return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "windwp/nvim-autopairs" },
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      dependencies = {
        { "rafamadriz/friendly-snippets" },
        { "saadparwaiz1/cmp_luasnip" },
      },
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    require("plugins.configs.cmp")
  end,
}

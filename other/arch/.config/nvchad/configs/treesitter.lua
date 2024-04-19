local opts = {}
opts = {
  indent = {
    enable = true,
    disable = {
      "html",
    },
  },
}
opts = vim.tbl_extend("force", require("plugins.configs.treesitter"), opts)
return opts

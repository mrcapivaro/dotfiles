return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {
    transparent_background = true,
    no_italic = true,
    integrations = {
      notify = true,
      mason = true,
      neotree = true,
      noice = true,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end
}


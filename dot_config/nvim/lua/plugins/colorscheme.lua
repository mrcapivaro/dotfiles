return {
  "catppuccin/nvim",
  name = "catppuccin",
  lazy = false,
  priority = 1000,
  init = function()
    vim.g.dark_theme = "catppuccin-mocha"
    vim.g.light_theme = "catppuccin-latte"
    vim.g.current_theme = vim.g.dark_theme
    vim.cmd.colorscheme(vim.g.current_theme)
  end,
  keys = {
    {
      "<leader>tt",
      function()
        local toggle_theme = vim.g.current_theme == vim.g.dark_theme
            and vim.g.light_theme
          or vim.g.dark_theme
        print(vim.toggle_theme)
        vim.g.current_theme = toggle_theme
        vim.cmd.colorscheme(vim.g.current_theme)
      end,
      desc = "Toggle theme dark/light",
    },
  },
  opts = {
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = "latte",
      dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = true, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
      enabled = false, -- dims the background color of inactive window
      shade = "dark",
      percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" }, -- Change the style of comments
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
      -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    default_integrations = true,
    integrations = {
      aerial = true,
      overseer = true,
      neotree = true,
      noice = true,
      mason = true,
      markdown = true,
      navic = { enabled = true },
      telescope = {
        enabled = true,
        -- style = "nvchad",
      },
    },
  },
}

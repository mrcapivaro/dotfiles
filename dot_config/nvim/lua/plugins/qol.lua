return {
  {
    "mg979/vim-visual-multi",
    event = { "BufReadPre", "BufNewFile" },
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = { ignore = "^$" },
  },

  {
    "barrett-ruth/live-server.nvim",
    cmd = { "LiveServerStart", "LiveServerStop", "LiveServerToggle" },
    keys = {
      {
        "<leader>ls",
        "<cmd>LiveServerToggle<cr>",
        desc = "Toggle Live Server",
      },
    },
    opts = function()
      local t = {}
      -- check for a WSL2 system
      if vim.fn.filereadable("/proc/sys/fs/binfmt_misc/WSLInterop") == 1 then
        t = {
          args = {
            "--browser=wslview",
          },
        }
      end
      return t
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    event = "VeryLazy",
    lazy = false,
    name = "colorizer",
    opts = {
      filetypes = { "css", "js", "ts", "html", "python", "c", "cpp", "ruby" },
      user_default_options = {
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes for `mode`: foreground, background,  virtualtext
        mode = "background", -- Set the display mode.
        -- Available methods are false / true / "normal" / "lsp" / "both"
        -- True is same as normal
        tailwind = true, -- Enable tailwind colors
        -- parsers can contain values used in |user_default_options|
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        -- update color values even if buffer is not focused
        -- example use: cmp_menu, cmp_docs
        always_update = false,
      },
      -- all the sub-options of filetypes apply to buftypes
      buftypes = {},
    },
  },

  {
    "ggandor/leap.nvim",
    event = "InsertEnter",
    config = function()
      local map = vim.keymap.set
      map("n", ";", "<Plug>(leap)")
      map({ "x", "o" }, ";", "<Plug>(leap-forward)")
    end,
  },
}

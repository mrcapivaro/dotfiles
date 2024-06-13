local options = {
  -- clipboard
  clipboard = "unnamedplus",
  -- indentation
  shiftwidth = 2,
  tabstop = 2,
  softtabstop = 2,
  expandtab = true,
  smartindent = true,
  -- ui
  termguicolors = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes",
  wrap = false,
  list = true,
  showmode = false,
  completeopt = "menu,menuone,noselect",
  cmdheight = 0,
  colorcolumn = "88",
  -- windows
  shellslash = false,
  -- search
  hlsearch = true,
  incsearch = true,
  -- files
  autowrite = true,
  swapfile = false,
  backup = false,
  -- misc
  ignorecase = true,
  spelllang = { "en" },
  -- scrolloff = 999,
  -- sidescrolloff = 8,
  updatetime = 50,
  virtualedit = "block",
  -- inccommand = "split",
  -- org
  conceallevel = 2,
  concealcursor = "nc",
}

for key, value in pairs(options) do
  vim.opt[key] = value
end

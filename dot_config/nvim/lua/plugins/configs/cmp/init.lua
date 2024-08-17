local cmp = require("cmp")
local defaults = require("cmp.config.default")()

-- nvim-autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
require("nvim-autopairs").setup()

-- UI
local Window = require("plugins.configs.cmp.ui").Window
local Formatting = require("plugins.configs.cmp.ui").Formatting

local Snippet = {
  expand = function(args)
    require("luasnip").lsp_expand(args.body)
  end,
}

local Completion = { completeopt = "menu,menuone,noinsert,noselect" }

local Sources = cmp.config.sources({
  { name = "nvim_lsp" },
  { name = "luasnip" },
  { name = "path" },
  {
    name = "buffer",
    option = {
      get_bufnrs = function()
        return vim.api.nvim_list_bufs()
      end,
    },
  },
})

local function disable_cmp_in_comments()
  local context = require("cmp.config.context")
  if vim.api.nvim_get_mode().mode == "c" then
    return true
  else
    return not context.in_treesitter_capture("comment")
      and not context.in_syntax_group("Comment")
  end
end

local Mapping = require("plugins.configs.cmp.mappings").Mapping

cmp.setup({
  window = Window,
  formatting = Formatting,
  completion = Completion,
  snippet = Snippet,
  mapping = Mapping,
  sources = Sources,
  sorting = defaults.sorting,
  enabled = disable_cmp_in_comments(),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources(
    { { name = "path" } },
    { { name = "cmdline", option = { ignore_cmds = { "Man", "!" } } } }
  ),
})

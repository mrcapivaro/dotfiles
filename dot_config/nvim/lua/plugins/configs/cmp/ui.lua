local M = {}

M.icons = {
  Text = "  ",
  Method = "  ",
  Function = "  ",
  Constructor = "  ",
  Field = "  ",
  Variable = "  ",
  Class = "  ",
  Interface = "  ",
  Module = "  ",
  Property = "  ",
  Unit = "  ",
  Value = "  ",
  Enum = "  ",
  Keyword = "  ",
  Snippet = "  ",
  Color = "  ",
  File = "  ",
  Reference = "  ",
  Folder = "  ",
  EnumMember = "  ",
  Constant = "  ",
  Struct = "  ",
  Event = "  ",
  Operator = "  ",
  TypeParameter = "  ",
}

M.Window = {
  completion = {
    scrollbar = false,
    border = "single",
    winhighlight = "Normal:CmpBorder,FloatBorder:None,Search:None",
  },
  documentation = {
    scrollbar = false,
    border = vim.g.FloatBorders,
    winhighlight = "Normal:CmpBorder,FloatBorder:None,Search:None",
  },
}

M.Formatting = {
  expandable_indicator = false,
  fields = { "abbr", "kind", "menu" },
  format = function(_, item)
    item.kind = (M.icons[item.kind] or "") .. "[" .. item.kind .. "]"
    return item
  end,
}

return M

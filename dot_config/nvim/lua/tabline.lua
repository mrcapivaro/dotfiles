local M = {}

M.render = function()
  local s = ""
  for i = 1, vim.fn.tabpagenr("$") do
    local winnr = vim.fn.tabpagewinnr(i)
    local buflist = vim.fn.tabpagebuflist(i)
    local bufnr = buflist[winnr]
    local bufname = vim.fn.bufname(bufnr)
    local bufmodified = vim.fn.getbufvar(bufnr, "&mod")
    s = s .. "%" .. i .. "T"
    s = s .. (i == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")
    s = s .. " " .. i .. ":"
    s = s
      .. (bufname ~= "" and vim.fn.fnamemodify(bufname, ":t") or "[No Name]")
    s = s .. (bufmodified == 1 and " [+]" or "")
    s = s .. " "
  end
  s = s .. "%#TabLineFill#"
  return s
end

vim.o.tabline = "%!v:lua.require('tabline').render()"

return M

-- Inspired from: https://github.com/MariaSolOs/dotfiles/blob/mac/.config/nvim/lua/statusline.lua
local M = {}

---@return string
M.mode_name = function()
  local mode = vim.api.nvim_get_mode().mode
  local mode_alias = {
    ["n"] = "Normal",
    ["no"] = "Op-Pending",
    ["nov"] = "Op-Pending",
    ["noV"] = "Op-Pending",
    ["no\22"] = "Op-Pending",
    ["niI"] = "Normal",
    ["niR"] = "Normal",
    ["niV"] = "Normal",
    ["nt"] = "Normal",
    ["ntT"] = "Normal",
    ["v"] = "Visual",
    ["vs"] = "Visual",
    ["V"] = "Visual",
    ["Vs"] = "Visual",
    ["\22"] = "Visual",
    ["\22s"] = "Visual",
    ["s"] = "Select",
    ["S"] = "Select",
    ["\19"] = "Select",
    ["i"] = "Insert",
    ["ic"] = "Insert",
    ["ix"] = "Insert",
    ["R"] = "Replace",
    ["Rc"] = "Replace",
    ["Rx"] = "Replace",
    ["Rv"] = "Virt Replace",
    ["Rvc"] = "Virt Replace",
    ["Rvx"] = "Virt Replace",
    ["c"] = "Command",
    ["cv"] = "Vim Ex",
    ["ce"] = "Ex",
    ["r"] = "Prompt",
    ["rm"] = "More",
    ["r?"] = "Confirm",
    ["!"] = "Shell",
    ["t"] = "Terminal",
  }
  local hl = "Normal"
  if mode_alias[mode] == "Insert" then
    hl = "Insert"
  elseif mode_alias[mode] == "Visual" then
    hl = "Visual"
  elseif mode_alias[mode] == "Command" then
    hl = "Command"
  end
  return table.concat({
    "%#" .. "MiniStatuslineMode" .. hl .. "#",
    " ",
    mode_alias[mode] or mode,
    " ",
    "%#" .. "Statusline" .. "#",
    " ",
  })
end

---@return string
M.filetype = function()
  local ok, icons = pcall(require, "nvim-web-devicons")
  if not ok then
    vim.notify("nvim-web-devicons not installed!", "WARN")
  end
  local ft = vim.fn.expand("%:e")
  local icon = icons.get_icon_by_filetype(ft)
  return (icon or "") .. " " .. ft .. " "
end

---@return string
M.current_file = function()
  return vim.fn.expand("%")
end

---@return string
M.position = function()
  local current_loc = vim.fn.line(".")
  local current_coc = vim.fn.virtcol(".")
  local total_loc = vim.fn.line("$")
  local file_percentage = math.floor(current_loc / total_loc * 100)
  return table.concat({
    "%#" .. "MiniStatuslineModeNormal" .. "#",
    " ",
    current_loc .. ":" .. current_coc .. " " .. file_percentage .. "%%",
    " ",
    "%#" .. "Statusline" .. "#",
    " ",
  })
end

---@return string
M.encoding = function()
  local encoding = vim.opt.fileencoding:get()
  if encoding == "utf-8" then
    return ""
  end
  return table.concat({
    " ",
    encoding,
    " ",
  })
end

--- Git status (if any).
---@return string
function M.gitsigns()
  local status = vim.b.gitsigns_status_dict
  if not status then
    return ""
  end
  local changes = {
    status.added and (status.added ~= 0) and ("+" .. status.added) or "",
    status.removed and (status.removed ~= 0) and ("-" .. status.removed) or "",
    status.changed and (status.changed ~= 0) and ("~" .. status.changed) or "",
  }
  return table.concat({
    " ",
    (" %s "):format(status.head),
    table.concat(changes, " "),
    " ",
  })
end

---@return string
M.render = function()
  return table.concat({
    M.mode_name(),
    M.gitsigns(),
    "%=",
    M.filetype(),
    M.encoding(),
    M.position(),
  })
end

vim.o.statusline = "%!v:lua.require('statusline').render()"

return M

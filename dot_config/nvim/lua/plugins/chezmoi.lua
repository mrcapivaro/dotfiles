local M = {
  "alker0/chezmoi.vim",
  lazy = false,
  init = function()
    vim.g["chezmoi#use_tmp_buffer"] = true
  end,
}

return M

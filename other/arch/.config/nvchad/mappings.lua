local M = {}

M.disabled = {
  n = {
    ["<C-n>"] = "",
    ["<C-h>"] = "",
    ["<C-j>"] = "",
    ["<C-k>"] = "",
    ["<C-l>"] = "",
    ["<leader>fm"] = "",
  },
  v = {
    ["<C-n>"] = "",
  },
}

M.aaa_myMappings = {
  n = {
    ["<leader>e"] = { "<cmd>NvimTreeToggle<cr>", "toggle nvim tree" },
    ["<C-d>"] = { "<C-d>zz", "move screen down" },
    ["<C-u>"] = { "<C-u>zz", "move screen up" },
    ["<leader>rr"] = {
      function()
        require("code_runner").run_code()
      end,
      "Run code with the code runner plugin.",
    },
    [";"] = { ":", "cmd" },
    ["<c-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "tmux-int window left" },
    ["<c-j>"] = { "<cmd>TmuxNavigateDown<cr>", "tmux-int window down" },
    ["<c-k>"] = { "<cmd>TmuxNavigateUp<cr>", "tmux-int window up" },
    ["<c-l>"] = { "<cmd>TmuxNavigateRight<cr>", "tmux-int window rigth" },
    ["<c-\\>"] = { "<cmd>TmuxNavigatePrevious<cr>", "tmux-int window previous" },
    ["<leader>fs"] = { "<cmd>Telescope symbols<cr>", "telescope symbols picker" },
    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format({ async = false })
      end,
      "LSP formatting",
    },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = { "<cmd>DapToggleBreakpoint<cr>", "add breakpoint at line" },
    ["<leader>dr"] = { "<cmd>DapContinue<cr>", "start or continue the debugger" },
  },
}

return M

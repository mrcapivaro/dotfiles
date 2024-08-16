return {
  {
    "alker0/chezmoi.vim",
    lazy = false,
    init = function()
      vim.g["chezmoi#use_tmp_buffer"] = true
    end,
  },

  {
    "mrjones2014/smart-splits.nvim",
    opts = {},
    lazy = false,
    config = function(_, opts)
      -- Resize splits
      vim.keymap.set("n", "<CS-h>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<CS-j>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<CS-k>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<CS-l>", require("smart-splits").resize_right)
      -- Move cursor between splits
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      -- Move buffer between splits
      vim.keymap.set(
        "n",
        "<leader><leader>h",
        require("smart-splits").swap_buf_left
      )
      vim.keymap.set(
        "n",
        "<leader><leader>j",
        require("smart-splits").swap_buf_down
      )
      vim.keymap.set(
        "n",
        "<leader><leader>k",
        require("smart-splits").swap_buf_up
      )
      vim.keymap.set(
        "n",
        "<leader><leader>l",
        require("smart-splits").swap_buf_right
      )
      require("smart-splits").setup(opts)
    end,
  },
}

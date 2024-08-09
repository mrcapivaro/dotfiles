---@type LazySpec
return {
	{
		"max397574/better-escape.nvim",
		opts = {
			mappings = {
				i = {
					k = {
						j = "<Esc>",
						k = "<Esc>",
					},
				},
			},
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					shiw_hidden_content = true,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						-- ".git",
						-- ".DS_Store",
						-- "thumbs.db"
					},
					never_show = {},
				},
			},
		},
	},
}

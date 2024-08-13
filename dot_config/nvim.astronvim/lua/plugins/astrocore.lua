---@type LazySpec
return {
	"AstroNvim/astrocore",
	---@type AstroCoreOpts
	opts = {
		features = {
			large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
			autopairs = true,                              -- enable autopairs at start
			cmp = true,                                    -- enable completion at start
			diagnostics_mode = 3,                          -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
			highlighturl = true,                           -- highlight URLs at start
			notifications = true,                          -- enable notifications at start
		},
		-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
		diagnostics = {
			virtual_text = true,
			underline = true,
		},
		options = {
			opt = {
				relativenumber = true,
				number = true,
				spell = false,
				signcolumn = "yes",
				wrap = false,
			},
			g = {
				-- ["chezmoi#use_tmp_buffer"] = true,
				-- ["chezmoi#source_dir_path"] = os.getenv("HOME") or os.getenv("USERPROFILE") .. "/.local/share/chezmoi",
			},
		},
		-- NOTE: keycodes follow the casing in the vimdocs;
		-- For example, `<Leader>` must be capitalized.
		mappings = {
			n = {
				["<tab>"] = {
					function()
						require("astrocore.buffer").nav(vim.v.count1)
					end,
					desc = "Next buffer",
				},
				["<S-tab>"] = {
					function()
						require("astrocore.buffer").nav(-vim.v.count1)
					end,
					desc = "Previous buffer",
				},
				["<C-S-J>"] = {
					require("smart-splits").resize_down,
					desc = "Decrease window height",
				},
				["<C-S-K>"] = {
					require("smart-splits").resize_up,
					desc = "Increase window height",
				},
				["<C-S-H>"] = {
					require("smart-splits").resize_left,
					desc = "Deacrease window length",
				},
				["<C-S-L>"] = {
					require("smart-splits").resize_right,
					desc = "Increase window length",
				},
				["<Leader>bd"] = {
					function()
						require("astroui.status.heirline").buffer_picker(function(bufnr)
							require("astrocore.buffer").close(bufnr)
						end)
					end,
					desc = "Close buffer from tabline",
				},
			},
		},
	},
}

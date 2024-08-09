-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.color.nvim-highlight-colors" },
	{ import = "astrocommunity.pack.lua" },
	{ import = "astrocommunity.pack.bash" },
	{ import = "astrocommunity.pack.ps1" },
	{ import = "astrocommunity.pack.html-css" },
	{ import = "astrocommunity.pack.cpp" },
	{ import = "astrocommunity.pack.python" },
	{ import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.code-runner.compiler-nvim" },
}

return {
	"alker0/chezmoi.vim",
	lazy = false,
	specs = {
		{
			"AstroNvim/astrocore",
			opts = {
				options = {
					g = {
						["chezmoi#use_tmp_buffer"] = true,
						["chezmoi#source_dir_path"] = os.getenv("HOME")
								or os.getenv("USERPROFILE") .. "/.local/share/chezmoi",
					},
				},
			},
		},
	},
}

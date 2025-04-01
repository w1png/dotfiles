return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			modules = {},
			ensure_installed = {
				"go",
				"lua",
				"python",
				"rust",
				"typescript",
				"typescript",
				"tsx",
				"css",
				"html",
				"vim",
				"dockerfile",
				"gitignore",
				"vimdoc",
				"markdown",
			},
			sync_install = false,
			auto_install = true,
			ignore_install = { "javascript" },

			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
				disable = { "python" },
			},
		})
	end,
}

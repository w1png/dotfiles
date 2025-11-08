return {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			modules = {},
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

return {
	"lmantw/themify.nvim",

	lazy = false,
	priority = 999,

	config = function()
		require("themify").setup({
			"blazkowolf/gruber-darker.nvim",
			{
				"ellisonleao/gruvbox.nvim",
				after = function()
					vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
				end,
			},
			{
				"Mofiqul/vscode.nvim",
				after = function()
					require("vscode").setup({
						transparent = true,
						italic_comments = true,
						underline_links = true,
					})
					vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
				end,
			},
			{
				"rose-pine/neovim",
				after = function()
					vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
				end,
			},
		})
	end,
}

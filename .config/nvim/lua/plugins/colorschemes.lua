return {
	"lmantw/themify.nvim",
	lazy = false,
	priority = 999,
	config = function()
		local transparent_bg = function()
			vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
		end
		require("themify").setup({
			{
				"blazkowolf/gruber-darker.nvim",
				after = transparent_bg,
			},
			{ "ellisonleao/gruvbox.nvim", after = transparent_bg }, -- after = transparent_bg },
			{
				"Mofiqul/vscode.nvim",
				after = function()
					require("vscode").setup({ transparent = true, italic_comments = true, underline_links = true })
					transparent_bg()
				end,
			},
			{ "rose-pine/neovim", after = transparent_bg },
		})
	end,
}

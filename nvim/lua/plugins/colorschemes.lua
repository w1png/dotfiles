return {
	-- {
	-- 	"blazkowolf/gruber-darker.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme gruber-darker")
	-- 		-- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
	-- 	end,
	-- },
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- require("catppuccin").setup({
	-- 		--   transparent_background = true,
	-- 		-- })
	-- 		-- vim.cmd("colorscheme catppuccin-mocha")
	-- 	end,
	-- },
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		-- vim.cmd("colorscheme gruvbox")
	-- 	end,
	-- },
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
				enable = {
					terminal = true,
					legacy_highlights = true,
				},
				styles = {
					bold = true,
					italic = false,
					transparency = true,
				},
			})
			vim.cmd("colorscheme rose-pine")
		end,
	},
}

return {
	"nvimtools/none-ls.nvim",
	event = "VeryLazy",
	opts = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.eslint_d,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,
				null_ls.builtins.formatting.goimports,
			},
		})
	end,
}

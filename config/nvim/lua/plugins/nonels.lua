return {
	"nvimtools/none-ls.nvim",
	config = function()
		local none_ls = require("null-ls")
		local biome = none_ls.builtins.formatting.biome.with({
			command = "biome",
			args = { "format", "--stdin", "$FILENAME" },
		})
		none_ls.setup({
			sources = {
				biome,
			},
		})
	end,
}

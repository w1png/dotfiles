return {
	"jose-elias-alvarez/null-ls.nvim",
	opts = function(_, opts)
		local biome = require("null-ls").builtins.formatting.rome.with({
			command = "biome",
		})
		opts.sources = vim.list_extend(opts.sources or {}, {
			biome,
		})
	end,
}

return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")

			mason_lspconfig.setup({
				automatic_installation = true,
				ensure_installed = {
					"biome",
					"tsserver",
					"html",
					"cssls",
					"jsonls",
					"lua_ls",
					"tailwindcss",
					"pyright",
					"gopls",
				},
			})

			local mason_tool_installer = require("mason-tool-installer")
			mason_tool_installer.setup({
				ensure_installed = {
					"stylua",
					"biome",
					"black",
					"pyright",
					"gopls",
					"biome",
				},
			})
		end,
	},
}

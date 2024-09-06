return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		-- "hrsh7th/cmp-nvim-lsp",
		"pmizio/typescript-tools.nvim",
		"nvim-lua/plenary.nvim",
		-- { "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
		keymap.set("n", "<leader>ci", function()
			vim.lsp.buf.code_action()
		end)
		keymap.set("n", "K", vim.lsp.buf.hover)

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				-- configure lua server (with special settings)
				lspconfig["lua_ls"].setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							-- make the language server recognize "vim" global
							diagnostics = {
								globals = { "vim" },
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				})
			end,
			["cssls"] = function()
				lspconfig["cssls"].setup({
					css = {
						validate = true,
						lint = {
							unknownAtRules = "ignore",
						},
					},
				})
			end,
			["tsserver"] = function()
				-- lspconfig["tsserver"].setup({
				-- 	capabilities = capabilities,
				-- 	on_attach = function(client)
				-- 		client.server_capabilities.documentFormattingProvider = false
				-- 	end,
				-- })
			end,
			["biome"] = function() end,
		})

		local typescript_tools = require("typescript-tools")
		typescript_tools.setup({
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
			end,
			settings = {
				separate_diagnostic_server = true,
				expose_as_code_action = "all",
			},
		})
	end,
}

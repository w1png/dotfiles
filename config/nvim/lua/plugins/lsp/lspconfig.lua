return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"pmizio/typescript-tools.nvim",
			event = { "BufReadPre", "BufNewFile" },
		},
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end)
		vim.keymap.set("n", "K", vim.lsp.buf.hover)

		local capabilities = cmp_nvim_lsp.default_capabilities()
		mason_lspconfig.setup_handlers({
			function(server_name)
				if server_name ~= "tsserver" then
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end
			end,
		})

		local typescript_tools = require("typescript-tools")
		typescript_tools.setup({
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				vim.lsp.buf_attach_client(bufnr, client.id)
			end,
			settings = {
				separate_diagnostic_server = true,
				expose_as_code_action = "all",
				-- Optimize tsserver performance
				tsserver_max_memory = 8192, -- Increase memory limit (in MB)
				tsserver_plugins = {}, -- Disable unnecessary plugins if any
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "none", -- Reduce inlay hint overhead
					includeCompletionsForModuleExports = true,
					quotePreference = "auto",
				},
			},
		})
	end,
}

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
		vim.keymap.set("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end)
		vim.keymap.set("n", "K", vim.lsp.buf.hover)

		local capabilities = require("blink.cmp").get_lsp_capabilities()
		mason_lspconfig.setup_handlers({
			function(server_name)
				local config = {
					capabilities = capabilities,
				}

				if server_name == "lua_ls" then
					config.settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					}
				end

				lspconfig[server_name].setup(config)
			end,
		})
	end,
}

local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.nvim"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.nvim`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/nvim-mini/mini.nvim",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.nvim | helptags ALL")
	vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	require("mini.basics").setup()
	require("mini.surround").setup()
	require("mini.pairs").setup()
	require("mini.indentscope").setup()
	require("mini.diff").setup()
	require("mini.icons").setup()

	require("mini.files").setup({
		windows = { preview = false },
		mappings = {
			close = "q",
			go_in = "l",
			go_in_plus = "<C-l>",
			go_out = "h",
			go_out_plus = "<C-h>",
			reset = "<BS>",
			reveal_cwd = "@",
			show_help = "g?",
			synchronize = "R",
			trim_left = "<",
			trim_right = ">",
		},
	})

	require("mini.comment").setup({ mappings = { comment_line = "<leader>/", comment_visual = "<leader>/" } })
	require("mini.extra").setup()
	require("mini.pick").setup({ mappings = { choose = "<CR>", toggle_preview = "<Tab>" } })
	require("mini.misc").setup()

	vim.keymap.set("n", "<leader>bb", require("mini.misc").zoom, { desc = "Zoom" })
end)

now(function()
	add({
		source = "lmantw/themify.nvim",
	})
	local void = function() end
	local transparent_bg = function()
		vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
	end
	require("themify").setup({
		{
			"folke/tokyonight.nvim",
			after = transparent_bg,
		},
		{
			"stevedylandev/ansi-nvim",
			after = function()
				vim.opt.termguicolors = false
			end,
		},
		{
			"blazkowolf/gruber-darker.nvim",
			after = transparent_bg,
		},
		{ "catppuccin/nvim", after = transparent_bg },
		{ "ellisonleao/gruvbox.nvim", after = void }, -- after = transparent_bg },
		{
			"Mofiqul/vscode.nvim",
			after = function()
				require("vscode").setup({ transparent = false, italic_comments = true, underline_links = true })
				transparent_bg()
			end,
		},
		{ "rose-pine/neovim", after = transparent_bg },
		"default",
	})
end)

now(function()
	add({
		source = "neovim/nvim-lspconfig",
		depends = {
			"saghen/blink.cmp",
			"saghen/blink.compat",
			"nvim-lua/plenary.nvim",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	})

	add({
		source = "stevearc/conform.nvim",
	})

	add({
		source = "saghen/blink.cmp",
	})

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	local opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "fallback" },
			["<S-Tab>"] = { "select_prev", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},

		completion = { documentation = { auto_show = true } },

		sources = {
			default = { "lsp", "path", "buffer" },
		},

		fuzzy = { implementation = "lua" },
	}

	local blink = require("blink.cmp")

	-- Mason setup
	require("mason").setup()
	require("mason-tool-installer").setup({})
	local mason_lspconfig = require("mason-lspconfig")

	-- LSP Config
	local lspconfig = require("lspconfig")
	local capabilities = require("blink.cmp").get_lsp_capabilities()
	mason_lspconfig.setup({
		automatic_installation = true,
		handlers = {
			function(server_name)
				local config = { capabilities = capabilities }
				if server_name == "lua_ls" then
					config.settings = {
						Lua = { diagnostics = { globals = { "vim", "MiniDeps" } } },
					}
				end
				lspconfig[server_name].setup(config)
			end,
		},
	})

	local conform = require("conform")
	conform.setup({
		formatters_by_ft = {
			javascript = { "biome" },
			typescript = { "biome" },
			javascriptreact = { "biome" },
			typescriptreact = { "biome" },
			css = { "prettier" },
			lua = { "stylua" },
			python = { "isort", "black" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1000,
		},
	})

	blink.setup(opts)
end)

now(function()
	add({
		source = "supermaven-inc/supermaven-nvim",
	})

	require("supermaven-nvim").setup({
		keymaps = {
			accept_suggestion = "<C-g>",
		},
	})
end)

later(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
	})

	local configs = require("nvim-treesitter.configs")

	configs.setup({
		modules = {},
		sync_install = false,
		auto_install = true,
		ignore_install = { "javascript" },

		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
			disable = { "python" },
		},
	})
end)

now(function()
	local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = "*",
	})
	require("options")
	require("keymaps")
end)

-- create a command called :notes that will open ~/notes/plans.md
vim.api.nvim_create_user_command("Notes", function()
	vim.cmd("edit ~/notes/plans.md")
end, {})

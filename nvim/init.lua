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

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local b = args.data.buf_id
			vim.keymap.set("n", "go", function()
				local entry = require("mini.files").get_fs_entry()
				if not entry then
					return
				end
				vim.fn.system({ "open", entry.path })
			end, { buffer = b, desc = "OS open" })
			vim.keymap.set("n", "gy", function()
				local entry = require("mini.files").get_fs_entry()
				if not entry then
					return
				end
				vim.fn.setreg("+", entry.path)
				vim.notify("Copied path to clipboard")
			end, { buffer = b, desc = "Yank path" })
		end,
	})

	require("mini.comment").setup({ mappings = { comment_line = "<leader>/", comment_visual = "<leader>/" } })
	require("mini.extra").setup()
	require("mini.pick").setup({ mappings = { choose = "<CR>", toggle_preview = "<Tab>" } })
	require("mini.misc").setup()

	vim.keymap.set("n", "<leader>zz", require("mini.misc").zoom, { desc = "Zoom" })
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
			"blazkowolf/gruber-darker.nvim",
			after = transparent_bg,
		},
		{ "catppuccin/nvim", after = transparent_bg },
		{ "ellisonleao/gruvbox.nvim", after = void }, -- after = transparent_bg },
		{
			"Mofiqul/vscode.nvim",
			after = function()
				require("vscode").setup({ transparent = true, italic_comments = true, underline_links = true })
				transparent_bg()
			end,
		},
		{ "rose-pine/neovim", after = transparent_bg },
		"default",
	})
end)

now(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
	})

	require("nvim-treesitter.configs").setup({
		modules = {},
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
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
		},
	})

	add({
		source = "stevearc/conform.nvim",
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
			lsp_fallback = false,
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

now(function()
	local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
	vim.api.nvim_create_autocmd("TextYankPost", {
		callback = function()
			vim.highlight.on_yank()
		end,
		group = highlight_group,
		pattern = "*",
	})
end)

now(function()
	local opt = vim.opt
	opt.clipboard = "unnamedplus"
	opt.mouse = "a"
	opt.number = true
	opt.relativenumber = true
	opt.wrap = false
	opt.scrolloff = 10
	opt.undofile = true
	opt.completeopt = "menuone,noselect"
	opt.hlsearch = false
	opt.ignorecase = true
	opt.smartcase = true
	opt.updatetime = 250
	opt.termguicolors = true
	opt.background = "dark"
	opt.expandtab = true
	opt.tabstop = 2
	opt.shiftwidth = 2
	opt.softtabstop = 2
	opt.showmode = false
	opt.laststatus = 0
	opt.ruler = false
	opt.showcmd = false

	vim.g.man_hardwrap = false
	vim.env.MANPAGER = ""
end)

later(function()
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	local keymap = vim.keymap

	keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

	-- Window navigation
	keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>", { silent = true })
	keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>", { silent = true })
	keymap.set("n", "<leader>k", "<cmd>wincmd k<CR>", { silent = true })
	keymap.set("n", "<leader>j", "<cmd>wincmd j<CR>", { silent = true })

	-- Diagnostics
	keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })

	-- LSP keymaps
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
	keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
	keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

	-- Mini keymaps
	keymap.set("n", "<leader>e", function()
		require("mini.files").open(vim.api.nvim_buf_get_name(0))
	end, { silent = true })

	keymap.set("n", "<leader><leader>", function()
		require("mini.pick").builtin.files({ tool = "rg" })
	end)
	keymap.set("n", "<leader>gg", function()
		require("mini.pick").builtin.grep_live({ tool = "rg" })
	end)

	keymap.set("n", "<leader>gc", function()
		require("mini.extra").pickers.git_commits()
	end)
	keymap.set("n", "<leader>gh", function()
		require("mini.extra").pickers.git_hunks()
	end)

	keymap.set("n", "<leader>gd", function()
		require("mini.extra").pickers.lsp({ scope = "definition" })
	end)
	keymap.set("n", "<leader>gr", function()
		require("mini.extra").pickers.lsp({ scope = "references" })
	end)
	keymap.set("n", "<leader>sd", function()
		require("mini.extra").pickers.diagnostic()
	end)
end)

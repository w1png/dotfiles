local opt = vim.opt
local map = vim.keymap.set

local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",

	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/LmanTW/themify.nvim",
	"https://github.com/f-person/git-blame.nvim",
	"https://github.com/supermaven-inc/supermaven-nvim",

	-- LSP & related
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/saghen/blink.cmp",
	"https://github.com/saghen/blink.compat",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/ray-x/go.nvim",
	"https://github.com/ray-x/guihua.lua",
	"https://github.com/stevearc/conform.nvim",
})

-- UI & Behavior
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.termguicolors = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.showmode = false
opt.laststatus = 0
opt.ruler = false
opt.showcmd = false
opt.background = "dark"

-- Indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true

-- Search
opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true

-- Undo & Backup
opt.undofile = true
opt.undolevels = 10000
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Performance & Misc
opt.updatetime = 250
opt.timeoutlen = 300
opt.ttimeoutlen = 0
opt.autoread = true
opt.autowrite = true
opt.completeopt = "menuone,noselect"
opt.backspace = "indent,eol,start"
opt.encoding = "UTF-8"
opt.smoothscroll = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

-- Windows & Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.diffopt:append("linematch:60")

-- Performance tuning
opt.redrawtime = 10000
opt.maxmempattern = 20000
opt.list = false

-- Global stuff
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.markdown_recommended_style = 0
vim.g.man_hardwrap = false
vim.env.MANPAGER = ""

-- Window navigation
map("n", "<C-h>", "<C-w>h", { remap = true })
map("n", "<C-j>", "<C-w>j", { remap = true })
map("n", "<C-k>", "<C-w>k", { remap = true })
map("n", "<C-l>", "<C-w>l", { remap = true })

-- Split creation
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontal" })
map("n", "<leader>sl", "<C-w>v", { desc = "Split vertical" })

-- Better vertical movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

map("n", "gl", "$", { desc = "Go to end of line" })

-- Visual mode improvements
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", '"_dP', { noremap = true, silent = true })

-- Simple auto-pairs
map("i", "`", "``<Left>")
map("i", '"', '""<Left>')
map("i", "(", "()<Left>")
map("i", "[", "[]<Left>")
map("i", "{", "{}<Left>")
map("i", "<", "<><Left>")

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- LSP keymaps
map("n", "<C-j>", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

vim.api.nvim_create_autocmd("VimResized", {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			map("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, { buffer = event.buf, silent = true, desc = "Quit buffer" })
		end)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = augroup("auto_create_dir"),
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- Filetype Detection
vim.filetype.add({
	extension = { env = "dotenv" },
	filename = { [".env"] = "dotenv" },
	pattern = {
		["[jt]sconfig.*.json"] = "jsonc",
		["%.env%.[%w_.-]+"] = "dotenv",
	},
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	group = augroup("env_filetype"),
	pattern = { "*.env", ".env.*" },
	callback = function()
		vim.opt_local.filetype = "sh"
	end,
})

-- Plugin Setup

-- Mini.nvim
require("mini.basics").setup()
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.indentscope").setup()
require("mini.diff").setup()
require("mini.icons").setup()
require("mini.comment").setup({
	mappings = { comment_line = "<leader>/", comment_visual = "<leader>/" },
})
require("mini.extra").setup()
require("mini.misc").setup()

-- Mini.files
local files = require("mini.files")
files.setup({
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

map("n", "<leader>e", function()
	files.open(vim.api.nvim_buf_get_name(0))
end, { silent = true, desc = "Mini Files" })

-- Mini.pick
require("mini.pick").setup({
	mappings = {
		choose = "<CR>",
		toggle_preview = "<Tab>",
		move_up = "<C-k>",
		move_down = "<C-j>",
		move_start = "<C-g>",
	},
})

map("n", "<leader><leader>", function()
	require("mini.pick").builtin.files({ tool = "rg" })
end, { desc = "Find files" })
map("n", "<leader>gg", function()
	require("mini.pick").builtin.grep_live({ tool = "rg" })
end, { desc = "Live grep" })
map("n", "<leader>gd", function()
	require("mini.pick").pickers.lsp({ scope = "definition" })
end, { desc = "Go to definition" })
map("n", "<leader>gr", function()
	require("mini.pick").pickers.lsp({ scope = "references" })
end, { desc = "References" })
map("n", "<leader>sd", function()
	require("mini.pick").pickers.diagnostic()
end, { desc = "Diagnostics" })

-- Mini.files extra mappings
vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local b = args.data.buf_id
		map("n", "go", function()
			local entry = files.get_fs_entry()
			if entry then
				vim.fn.system({ "open", entry.path })
			end
		end, { buffer = b, desc = "Open with OS" })

		map("n", "gy", function()
			local entry = files.get_fs_entry()
			if entry then
				vim.fn.setreg("+", entry.path)
				vim.notify("Copied path to clipboard")
			end
		end, { buffer = b, desc = "Yank path" })
	end,
})

map("n", "<leader>zz", require("mini.misc").zoom, { desc = "Zoom window" })

-- Colorschemes
local transparent = function()
	vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
end

require("themify").setup({
	{ "folke/tokyonight.nvim", after = transparent },
	{ "blazkowolf/gruber-darker.nvim", after = transparent },
	{ "catppuccin/nvim", after = transparent },
	{ "ellisonleao/gruvbox.nvim", after = transparent },
	{
		"navarasu/onedark.nvim",
		after = function()
			require("onedark").setup({ style = "darker" })
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		after = function()
			require("vscode").setup({ transparent = true })
			transparent()
		end,
	},
	{ "rose-pine/neovim", after = transparent },
	"default",
})

require("gitblame").setup()
require("supermaven-nvim").setup({ keymaps = { accept_suggestion = "<C-g>" } })
require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"go",
		"tsx",
		"jsx",
		"vim",
		"vimdoc",
		"query",
		"lua",
		"c",
		"javascript",
		"typescript",
		"html",
		"sql",
		"css",
	},
	callback = function()
		pcall(vim.treesitter.start)
		if vim.bo.indentexpr == "" then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

require("go").setup()

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.go",
	callback = function()
		require("go.format").goimports()
	end,
	group = vim.api.nvim_create_augroup("GoFormat", {}),
})

require("conform").setup({
	formatters_by_ft = {
		javascript = { "biome" },
		typescript = { "biome" },
		javascriptreact = { "biome" },
		typescriptreact = { "biome" },
		css = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
	},
	format_on_save = { lsp_fallback = false, async = false, timeout_ms = 1000 },
})

require("blink.cmp").setup({
	keymap = {
		preset = "enter",
		["<Tab>"] = { "select_next", "fallback" },
		["<S-Tab>"] = { "select_prev", "fallback" },
	},
	appearance = { nerd_font_variant = "mono" },
	completion = { documentation = { auto_show = true } },
	sources = { default = { "lsp", "path", "buffer" } },
	fuzzy = { implementation = "lua" },
})

require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})
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

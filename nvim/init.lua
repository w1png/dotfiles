local opt = vim.opt
local map = vim.keymap.set

vim.pack.add({
	"https://github.com/nvim-mini/mini.nvim",
	"https://github.com/esmuellert/codediff.nvim",
	"https://github.com/w1png/run.nvim",

	-- Themes
	"https://github.com/folke/tokyonight.nvim",
	"https://github.com/blazkowolf/gruber-darker.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/Mofiqul/vscode.nvim",
	"https://github.com/rose-pine/neovim",
	"https://github.com/monkoose/neocodeium",
	-- End themes

	-- LSP & related
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/neovim/nvim-lspconfig",
	{
		src = "https://github.com/saghen/blink.lib",
		-- Match the configuration API used by the locked Blink v2 revision.
		version = "c8fdc12c8a2fab6cf786dd7141a283f8079f902b",
	},
	"https://github.com/saghen/blink.cmp",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/stevearc/conform.nvim",

	{
		src = "https://github.com/mrcjkb/rustaceanvim",
		version = vim.version.range("^9"),
	},
})

vim.g.rustaceanvim = {
	tools = { enable_clippy = false },
	server = {
		default_settings = {
			["rust-analyzer"] = {
				diagnostics = { enable = true },
			},
		},
	},
}

local augroup = function(name)
	return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

opt.termguicolors = true
opt.background = "dark"
require("gruvbox").setup({ transparent_mode = true })
vim.cmd.colorscheme("gruvbox")

-- UI & Behavior
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 10
opt.sidescrolloff = 10
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.showmode = false
opt.laststatus = 0
opt.ruler = false
opt.showcmd = false

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
opt.backspace = "indent,eol,start"
opt.encoding = "UTF-8"
opt.smoothscroll = true
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.redrawtime = 10000
opt.maxmempattern = 20000
opt.list = false

-- Windows & Splits
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.diffopt:append("linematch:60")

-- Global stuff
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.markdown_recommended_style = 0
vim.g.man_hardwrap = false
vim.env.MANPAGER = ""

-- Better vertical movement
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<C-j>", "<C-e>", { desc = "Scroll screen down" })
map({ "n", "x" }, "<C-k>", "<C-y>", { desc = "Scroll screen up" })

-- Visual mode improvements
map("v", "<", "<gv")
map("v", ">", ">gv")
map("v", "p", '"_dP', { noremap = true, silent = true })

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Run selected shell commands into an editable output buffer.
map({ "n", "x" }, "<leader>sh", function()
	local mode = vim.fn.mode()
	local lines = { vim.api.nvim_get_current_line() }
	if mode == "v" or mode == "V" or mode == "\22" then
		lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), {
			type = mode,
			exclusive = vim.o.selection == "exclusive",
		})
		vim.cmd.normal({ args = { "\27" }, bang = true })
	end
	local command = table.concat(lines, "\n")
	if vim.trim(command) == "" then
		return
	end
	local buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_open_win(buf, true, { split = "right", win = 0 })
	vim.wo.diff, vim.wo.scrollbind, vim.wo.cursorbind = false, false, false
	map("n", "q", "<Cmd>close<CR>", { buffer = buf, desc = "Close shell output window" })
	vim.system(
		{ vim.o.shell, "-ic", command },
		{
			cwd = vim.fn.getcwd(),
			env = { ZSH_TMUX_AUTOSTARTED = "true" },
			text = true,
		},
		vim.schedule_wrap(function(result)
			if not vim.api.nvim_buf_is_loaded(buf) then
				return
			end
			local output = result.stdout or ""
			if result.stderr and result.stderr ~= "" then
				output = output .. (output == "" and "" or "\n") .. result.stderr
			end
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output:gsub("\n$", ""), "\n", { plain = true }))
			if output:match("^%s*[%[{]") then
				vim.bo[buf].filetype = "json"
			end
			if result.code ~= 0 then
				vim.notify("Shell command exited with code " .. result.code, vim.log.levels.WARN)
			end
		end)
	)
end, { desc = "Run selection or current line in shell" })

-- LSP keymaps
vim.diagnostic.config({ update_in_insert = true })
vim.lsp.inlay_hint.enable(false)
vim.api.nvim_create_autocmd("LspAttach", {
	group = augroup("rust_diagnostics"),
	callback = function(event)
		vim.lsp.inlay_hint.enable(false, { bufnr = event.buf })
		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client.name == "rust-analyzer" then
			vim.diagnostic.config({ virtual_text = true }, vim.lsp.diagnostic.get_namespace(client.id))
		end
	end,
})
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostic float" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

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

-- Plugin Setup

-- Mini.nvim
require("mini.surround").setup()
require("mini.pairs").setup()
require("mini.indentscope").setup()
require("mini.diff").setup()
require("mini.icons").setup()
require("mini.trailspace").setup()
require("mini.extra").setup()
require("mini.misc").setup()
require("mini.comment").setup({
	mappings = { comment_line = "<leader>/", comment_visual = "<leader>/" },
})

local mini_hipatterns = require("mini.hipatterns")
mini_hipatterns.setup({
	highlighters = {
		-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
		fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
		hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
		todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
		note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

		hex_color = mini_hipatterns.gen_highlighter.hex_color(),
	},
})

-- Mini.files
local files = require("mini.files")
files.setup({
	content = {
		prefix = function(entry)
			local icon, highlight = files.default_prefix(entry)
			local size = entry.fs_type == "file" and vim.fn.getfsize(entry.path) or -1
			local label = "-"
			if size >= 0 then
				local units = { "B", "KiB", "MiB", "GiB", "TiB" }
				local unit = 1
				while size >= 1024 and unit < #units do
					size, unit = size / 1024, unit + 1
				end
				label = (unit == 1 and "%d%s" or "%.1f%s"):format(size, units[unit])
			end
			return ("%s%9s "):format(icon, label), highlight
		end,
	},
	options = {
		use_as_default_explorer = true,
		permanent_delete = false,
	},
	windows = { preview = false },
	mappings = {
		go_in_plus = "<C-l>",
		go_out_plus = "<C-h>",
		synchronize = "R",
	},
})

map("n", "<leader>e", function()
	files.open(vim.api.nvim_buf_get_name(0))
end, { silent = true, desc = "Mini Files" })

-- Mini.pick
require("mini.pick").setup({
	mappings = {
		move_up = "<C-k>",
		move_down = "<C-j>",
	},
})

map("n", "<leader>rr", function()
	require("run.nvim").pick()
end)
map("n", "<leader><leader>", function()
	require("mini.pick").builtin.files({ tool = "rg" })
end, { desc = "Find files" })
map("n", "<leader>gg", function()
	require("mini.pick").builtin.grep_live({ tool = "rg" })
end, { desc = "Live grep" })
map("n", "<leader>gd", function()
	require("mini.extra").pickers.lsp({ scope = "definition" })
end, { desc = "Go to definition" })
map("n", "<leader>gr", function()
	require("mini.extra").pickers.lsp({ scope = "references" })
end, { desc = "References" })
map("n", "<leader>sd", function()
	require("mini.extra").pickers.diagnostic()
end, { desc = "Diagnostics" })

-- Git review
require("codediff").setup({
	explorer = {
		focus_on_select = true,
		visible_groups = { staged = false, unstaged = true, conflicts = true },
	},
})

map("n", "<leader>gh", "<Cmd>CodeDiff<CR>", { desc = "Review unstaged and untracked files" })

vim.keymap.set("n", "<leader>gb", function()
	local file = vim.api.nvim_buf_get_name(0)
	if file == "" or vim.bo.buftype ~= "" then
		vim.notify("Git blame requires a file buffer", vim.log.levels.WARN)
		return
	end
	local line = vim.api.nvim_win_get_cursor(0)[1]

	vim.system({
		"git",
		"-C",
		vim.fs.dirname(file),
		"blame",
		"-L",
		line .. "," .. line,
		"--porcelain",
		"--",
		file,
	}, { text = true }, function(result)
		vim.schedule(function()
			if result.code ~= 0 then
				vim.notify(result.stderr, vim.log.levels.ERROR)
				return
			end

			local hash = result.stdout:match("^([^%s]+)")
			local author = result.stdout:match("\nauthor ([^\n]+)")
			local summary = result.stdout:match("\nsummary ([^\n]+)")

			if hash then
				hash = hash:sub(1, 7)
			else
				hash = "0000000"
			end

			if not author then
				author = "Not committed yet"
			end

			local text = hash .. " • " .. author
			if summary then
				text = text .. " • " .. summary
			end

			vim.notify(text)
		end)
	end)
end, { desc = "Git blame line" })

local neocodeium = require("neocodeium")
neocodeium.setup()
vim.keymap.set("i", "<C-g>", neocodeium.accept)

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"go",
		"rust",
		"tsx",
		"jsx",
		"typescriptreact",
		"javascriptreact",
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

require("mini.ai").setup()

local function project_formatter(bufnr)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local directory = filename ~= "" and vim.fs.dirname(filename) or vim.fn.getcwd()
	local root = vim.fs.root(directory, ".git")
	local function configured(tool)
		return vim.fs.find(function(name)
			if tool == "biome" then
				return name:match("^%.?biome%.jsonc?$") ~= nil
			end
			local ext = name:match("^%.prettierrc%.(%w+)$")
			return name == ".prettierrc"
				or name:match("^prettier%.config%.[cm]?[jt]s$") ~= nil
				or (
					ext ~= nil
					and (
						ext:match("^[cm]?[jt]s$") ~= nil
						or vim.tbl_contains({ "json", "json5", "yaml", "yml", "toml" }, ext)
					)
				)
		end, { path = directory, upward = true, type = "file", stop = root and vim.fs.dirname(root) })[1] ~= nil
	end
	local biome, prettier = configured("biome"), configured("prettier")
	while directory and not biome do
		local ok, lines = pcall(vim.fn.readfile, vim.fs.joinpath(directory, "package.json"))
		if ok then
			local valid, package = pcall(vim.json.decode, table.concat(lines, "\n"))
			if valid and type(package) == "table" then
				prettier = prettier or type(package.prettier) == "table" or type(package.prettier) == "string"
				for _, group in ipairs({ "dependencies", "devDependencies", "optionalDependencies" }) do
					local deps = package[group]
					if type(deps) == "table" then
						biome = biome or type(deps["@biomejs/biome"]) == "string"
						prettier = prettier or type(deps.prettier) == "string"
					end
				end
			end
		end
		if directory == root then
			break
		end
		local parent = vim.fs.dirname(directory)
		directory = parent ~= directory and parent or nil
	end
	return { biome and "biome" or prettier and "prettier" or "biome" }
end

local conform = require("conform")
local format_on_save = true

conform.setup({
	default_format_opts = { lsp_format = "never", timeout_ms = 1000 },
	formatters_by_ft = {
		javascript = project_formatter,
		typescript = project_formatter,
		javascriptreact = project_formatter,
		typescriptreact = project_formatter,
		css = project_formatter,
		json = project_formatter,
		jsonc = project_formatter,
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt" },
	},
	format_on_save = function()
		if format_on_save then
			return {}
		end
	end,
})

vim.api.nvim_create_user_command("Format", function()
	if vim.tbl_isempty(conform.list_formatters(0)) then
		local filetype = vim.bo.filetype ~= "" and vim.bo.filetype or "unset"
		vim.notify("No formatter available for filetype: " .. filetype, vim.log.levels.WARN)
		return
	end
	conform.format({ async = false })
end, { desc = "Format current buffer" })

vim.api.nvim_create_user_command("ToggleFormat", function()
	format_on_save = not format_on_save
	vim.notify("Format on save " .. (format_on_save and "enabled" or "disabled"))
end, { desc = "Toggle format on save" })

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
vim.lsp.config("*", {
	capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				library = { vim.env.VIMRUNTIME },
				checkThirdParty = false,
			},
		},
	},
})
require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"cssls",
		"gopls",
		"html",
		"jsonls",
		"lua_ls",
		"rust_analyzer",
		"tailwindcss",
		"vtsls",
	},
	automatic_enable = { exclude = { "rust_analyzer" } },
})

require("plugin")

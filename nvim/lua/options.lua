local opt = vim.opt

opt.clipboard = "unnamedplus"
opt.mouse = "a"

opt.number = true
opt.relativenumber = true

opt.wrap = false
opt.scrolloff = 1
opt.breakindent = true
opt.undofile = true
opt.signcolumn = "yes"
opt.completeopt = "menuone,noselect"

opt.hlsearch = false
opt.ignorecase = true
opt.smartcase = true
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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "man",
	callback = function()
		vim.bo.buflisted = false
		vim.wo.conceallevel = 0
	end,
})

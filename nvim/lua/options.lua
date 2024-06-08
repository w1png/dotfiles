vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.hlsearch = false
vim.o.clipboard = 'unnamedplus'
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.wrap = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'
vim.o.termguicolors = true
vim.o.completeopt = 'menuone,noselect'
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.o.showmode = false
vim.o.laststatus = 0
vim.o.ruler = false
vim.o.showcmd = false


vim.keymap.set('n', '<leader>b<Right>', '<cmd>:wincmd l<CR>', { silent = true })
vim.keymap.set('n', '<leader>b<Left>', '<cmd>:wincmd h<CR>', { silent = true })
vim.keymap.set('n', '<leader>b<Up>', '<cmd>:wincmd k<CR>', { silent = true })
vim.keymap.set('n', '<leader>b<Down>', '<cmd>:wincmd j<CR>', { silent = true })
vim.keymap.set('n', '<leader>bs', '<cmd>:split<CR>', { silent = true })
vim.keymap.set('n', '<leader>bv', '<cmd>:vsplit<CR>', { silent = true })


vim.o.scrolloff = 1


vim.keymap.set('n', '<C-j>', '<cmd>lua vim.diagnostic.open_float()<CR>', { silent = true })



-- nnoremap <Left>  :echoe "Use h"<CR>
-- nnoremap <Right> :echoe "Use l"<CR>
-- nnoremap <Up>    :echoe "Use k"<CR>
-- nnoremap <Down>  :echoe "Use j"<CR>

-- local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]
--
--
-- vim.api.nvim_set_keymap('i', '<Up>', '<C-o>' .. msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('i', '<Down>', '<C-o>' .. msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('i', '<Left>', '<C-o>' .. msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('i', '<Right>', '<C-o>' .. msg, { noremap = true, silent = false })
--
--
-- vim.api.nvim_set_keymap('n', '<Up>', msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<Down>', msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<Left>', msg, { noremap = true, silent = false })
-- vim.api.nvim_set_keymap('n', '<Right>', msg, { noremap = true, silent = false })

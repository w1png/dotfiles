vim.opt.wrap = false;

vim.g.copilot_no_tab_map = true;
vim.api.nvim_set_keymap('i', '<C-G>', 'copilot#Accept("<CR>")', {noremap = true, silent = true, expr = true});

require("neoscroll").setup()

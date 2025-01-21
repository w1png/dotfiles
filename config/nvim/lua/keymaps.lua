vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

keymap.set("n", "<leader>b<Right>", "<cmd>:wincmd l<CR>", { silent = true })
keymap.set("n", "<leader>b<Left>", "<cmd>:wincmd h<CR>", { silent = true })
keymap.set("n", "<leader>b<Up>", "<cmd>:wincmd k<CR>", { silent = true })
keymap.set("n", "<leader>b<Down>", "<cmd>:wincmd j<CR>", { silent = true })

keymap.set("n", "<C-j>", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true })

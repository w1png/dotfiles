vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Window navigation
keymap.set("n", "<leader>bl", "<cmd>wincmd l<CR>", { silent = true })
keymap.set("n", "<leader>bh", "<cmd>wincmd h<CR>", { silent = true })
keymap.set("n", "<leader>bk", "<cmd>wincmd k<CR>", { silent = true })
keymap.set("n", "<leader>bj", "<cmd>wincmd j<CR>", { silent = true })

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
  require("mini.pick").builtin.files()
end)
keymap.set("n", "<leader>gg", function()
  require("mini.pick").builtin.grep_live({ tool = "rg" })
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

keymap.set({ "n", "v", "i" }, "<Up>", "<Nop>", { silent = true })
keymap.set({ "n", "v", "i" }, "<Down>", "<Nop>", { silent = true })
keymap.set({ "n", "v", "i" }, "<Left>", "<Nop>", { silent = true })
keymap.set({ "n", "v", "i" }, "<Right>", "<Nop>", { silent = true })

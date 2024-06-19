return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local telescope = require("telescope")
			telescope.setup({
				pickers = {
					find_files = {
						hidden = true,
					},
				},

				defaults = {
					generic_sorter = require("mini.fuzzy").get_telescope_sorter,
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
					color_devicons = true,
					file_ignore_patterns = { ".git/", "node_modules" },
				},
			})

			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>gg", builtin.live_grep, { desc = "[G]rep [G]rep" })
			vim.keymap.set("n", "<leader><space>", builtin.find_files, { desc = "Search Files" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		end,
	},
}

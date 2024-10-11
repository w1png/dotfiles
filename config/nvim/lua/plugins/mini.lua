return {
	{
		"OXY2DEV/markview.nvim",
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.basics").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.indentscope").setup()
			require("mini.diff").setup()
			require("mini.icons").setup()

			require("mini.files").setup({
				windows = {
					preview = false,
				},
				mappings = {
					close = "q",
					go_in = "<Right>",
					go_in_plus = "<C-Right>",
					go_out = "<Left>",
					go_out_plus = "<C-Left>",
					reset = "<BS>",
					reveal_cwd = "@",
					show_help = "g?",
					synchronize = "R",
					trim_left = "<",
					trim_right = ">",
				},
			})

			vim.keymap.set("n", "<leader>e", function()
				MiniFiles.open(vim.api.nvim_buf_get_name(0))
			end, { silent = true })

			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})

			local misc = require("mini.misc")
			misc.setup()
			vim.keymap.set("n", "<leader>bb", misc.zoom, { desc = "Zoom" })

			require("mini.comment").setup({
				mappings = {
					comment_line = "<leader>/",
					comment_visual = "<leader>/",
				},
			})

			local extra = require("mini.extra")
			extra.setup()
			local pick = require("mini.pick")
			pick.setup({
				mappings = {
					choose = "<CR>",
					toggle_preview = "<Tab>",
				},
			})
			vim.keymap.set("n", "<leader><leader>", function()
				pick.builtin.files()
			end)
			vim.keymap.set("n", "<leader>gg", function()
				pick.builtin.grep_live()
			end)
			vim.keymap.set("n", "<leader>gd", function()
				extra.pickers.lsp({ scope = "definition" })
			end)
			vim.keymap.set("n", "<leader>gs", function()
				extra.pickers.lsp({ scope = "document_symbol" })
			end)
			vim.keymap.set("n", "<leader>gr", function()
				extra.pickers.lsp({ scope = "references" })
			end)
			vim.keymap.set("n", "<leader>sd", function()
				extra.pickers.diagnostic()
			end)
		end,
	},
}

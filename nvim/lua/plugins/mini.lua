return {
	{
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			require("mini.basics").setup()
			require("mini.surround").setup()
			require("mini.pairs").setup()
			require("mini.indentscope").setup()
			require("mini.notify").setup()

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
			vim.keymap.set("n", "<leader>e", ":lua MiniFiles.open()<CR>", { silent = true })

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
		end,
	},
}

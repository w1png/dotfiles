return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.basics").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.indentscope").setup()
		require("mini.diff").setup()
		require("mini.icons").setup()
		require("mini.icons").setup()

		require("mini.files").setup({
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

		require("mini.comment").setup({ mappings = { comment_line = "<leader>/", comment_visual = "<leader>/" } })
		require("mini.extra").setup()
		require("mini.pick").setup({ mappings = { choose = "<CR>", toggle_preview = "<Tab>" } })
		require("mini.misc").setup()

		-- Add zoom keymap here
		vim.keymap.set("n", "<leader>bb", require("mini.misc").zoom, { desc = "Zoom" })
	end,
}

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

		local MiniFiles = require("mini.files")
		MiniFiles.setup({
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
			pick.builtin.grep_live({
				tool = "rg",
			})
		end)
		vim.keymap.set("n", "<leader>gd", function()
			extra.pickers.lsp({ scope = "definition" })
		end)
		vim.keymap.set("n", "<leader>gr", function()
			extra.pickers.lsp({ scope = "references" })
		end)
		vim.keymap.set("n", "<leader>sd", function()
			extra.pickers.diagnostic()
		end)
	end,
}

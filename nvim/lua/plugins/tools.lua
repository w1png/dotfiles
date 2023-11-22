local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

return {
  {
		"ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>r",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				expr = false,
			},
		},
		opts = {},
	},
  {
  "karb94/neoscroll.nvim",
  config = function ()
    vim.keymap.set('n', '<ScrollWheelUp>', '<C-y>')
    vim.keymap.set('n', '<ScrollWheelDown>', '<C-e>')
    vim.keymap.set('i', '<ScrollWheelUp>', '<C-y>')
    vim.keymap.set('i', '<ScrollWheelDown>', '<C-e>')
    vim.keymap.set('v', '<ScrollWheelUp>', '<C-y>')
    vim.keymap.set('v', '<ScrollWheelDown>', '<C-e>')

    require('neoscroll').setup {
      mappings = { '<C-y>', '<C-e>' },
    }
  end
},
  {
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			require("incline").setup({})
    end
  },
  {
      'numToStr/Comment.nvim',
      opts = {},
      lazy = false,
      config = function()

      vim.keymap.set('n', '<leader>/', ':lua require("Comment.api").toggle.linewise.current()<CR>', { silent = true })
      vim.keymap.set('v', '<leader>/', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { silent = true })
      end
  },
  {
    'ggandor/leap.nvim',
    config = function ()
      require("leap").add_default_mappings()
    end
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
}

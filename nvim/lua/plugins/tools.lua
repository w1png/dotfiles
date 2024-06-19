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
      vim.keymap.set('v', '<leader>/', ':lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
        { silent = true })
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {}
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
}

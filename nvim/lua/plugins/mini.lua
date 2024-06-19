return {
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.basics').setup()
      require('mini.surround').setup()
      require('mini.pairs').setup()
      require('mini.indentscope').setup()
      require('mini.notify').setup()

      local misc = require('mini.misc')
      misc.setup()
      vim.keymap.set('n', '<leader>bb', misc.zoom, { desc = 'Zoom' })

      require('mini.comment').setup({
        mappings = {
          comment_line = '<leader>/',
          comment_visual = '<leader>/',
        }
      })
    end
  },
}

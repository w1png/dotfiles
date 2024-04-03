return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
      vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      -- vim.cmd([[colorscheme gruvbox]])
      -- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    end,
  },
  {
    'Mofiqul/vscode.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd [[colorscheme vscode]]
      -- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    end
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = false,
        undercurl = true,
        transparent = false,
        dimInactive = false,
      })

      -- vim.cmd([[colorscheme kanagawa-dragon]])
    end
  },
  {
    'shaunsingh/nord.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.o.background = "dark"
      -- vim.cmd([[colorscheme nord]])
    end,
  },
  {
    "j-hui/fidget.nvim",
    opts = {},
  },
  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            hidden = true,
          }
        },

        defaults = {
          mappings = {
            i = {
              ['<C-u>'] = false,
              ['<C-d>'] = false,
            },
          },
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          file_ignore_patterns = { "node_modules" },
        },
      }

      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'noice')
      pcall(require('telescope').load_extension, 'colors')

      local builtin = require('telescope.builtin')

      vim.keymap.set('n', '<leader>gg', builtin.live_grep, { desc = '[G]rep [G]rep' })
      vim.keymap.set('n', '<leader><space>', builtin.find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "[G]it [S]tatus" })
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make', },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    config = function()
      require("notify").setup({
        background_colour = "#000000",
      })
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          inc_rename = false,
          lsp_doc_border = false,
        },

        vim.keymap.set("n", "<leader>nd", "<cmd>Noice dismiss<cr>", { desc = "Dismiss all messages" }),
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
}

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.cmd([[colorscheme gruvbox]])
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
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require('nvim-tree').setup({
        disable_netrw = true,
        hijack_netrw = true,
        hijack_cursor = true,
        hijack_unnamed_buffer_when_opening = true,
        sync_root_with_cwd = true,

        actions = {
          open_file = {
            resize_window = true,
          },
        },

        update_focused_file = {
          enable = true,
          update_root = false,
        },

        filesystem_watchers = {
          enable = true,
        },
        view = {
          adaptive_size = false,
          side = "left",
          width = 30,
          preserve_window_proportions = true,
        },
        git = {
          enable = true,
          ignore = false,
        },

        renderer = {
          root_folder_label = false,
          highlight_git = false,
          highlight_opened_files = "none",

          indent_markers = {
            enable = false,
          },

          icons = {
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },

            glyphs = {
              default = "󰈚",
              symlink = "",
              folder = {
                empty = "",
                empty_open = "",
                open = "",
                symlink = "",
                symlink_open = "",
                arrow_open = "",
                arrow_closed = "",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "",
                renamed = "➜",
                untracked = "★",
                deleted = "",
                ignored = "◌",
              },
            },
          },
        },

        filters = {
          dotfiles = false,
        },
      })

      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFocus<CR>', { noremap = true, silent = true })
      vim.api.nvim_create_autocmd('VimEnter', {
        command = 'if empty(expand("%")) || expand("%") == "startify" || expand("%") == "" | NvimTreeToggle | endif',
        group = 'NvimTree',
        pattern = '*',
      })
    end
  },

  {
    'nvim-telescope/telescope.nvim', tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {
        pickers = {
          colorscheme = {
            enable_preview = true,
            theme = "dropdown",
          },
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

      vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gg', ':lua require("telescope.builtin").live_grep()<CR>',
        { noremap = true, silent = true })
      vim.keymap.set('n', '<leader><space>', require('telescope.builtin').find_files, { desc = 'Search Files' })
      vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
    end
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

  {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup {
          signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
          },
        }
      end
  },
}


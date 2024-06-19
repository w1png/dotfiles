return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    'f-person/git-blame.nvim',
    config = function()
      require('gitblame').setup {
        enabled = true,
      }
    end
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  {
    "kyazdani42/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
                default = "",
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

      require('nvim-web-devicons').setup({})

      vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  },
  {
    "blazkowolf/gruber-darker.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd([[colorscheme gruber-darker]])
      -- vim.o.background = "dark"
      -- vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      -- require("catppuccin").setup({
      --   transparent_background = true,
      -- })
      -- vim.cmd([[colorscheme catppuccin-mocha]])
    end
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.o.background = "dark"
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
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        styles = {
          comments = { italic = true },
          sidebars = "dark",
          floats = "dark",
        },
        sidebars = { "qf", "help" },
        dim_inactive = false, -- dims inactive windows
      })
      vim.cmd([[colorscheme tokyonight]])
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
    }
  },
}

return {
  ["github/copilot.vim"] = {},
  ['andweeb/presence.nvim'] = {
    auto_update         = true,
    main_image          = 'neovim',
    client_id           = '462281985134428170',
    show_time           = true,

    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Working on %s",
    line_number_text    = "Line %s out of %s",
  },

  ["f-person/git-blame.nvim"] = {},
  ['ellisonleao/glow.nvim'] = {},
  ['moll/vim-bbye'] = {},
  ['aymericbeaumet/vim-symlink'] = {},
  ["karb94/neoscroll.nvim"] = {},
  -- pep8 checker
  ["nvie/vim-flake8"] = {},
  ["williamboman/mason.nvim"] = {
    override_options = {
       ensure_installed = {
        "markdownlint",
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "pyright",
        "shfmt",
        "shellcheck",
        "gopls",
        "autopep8",
        "bash-language-server",
        "beautysh",
        "dockerfile-language-server",
        "fixjson",
        "goimports",
        "golangci-lint",
        "jsonlint",
        "lua-language-server",
        "marksman",
        "rust-analyzer",
        "omnisharp",
      },
    },
  },
  -- automatically save workspaces
  ["rmagatti/auto-session"] = {
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = true,
    auto_restore_enabled = true,
    auto_session_suppress_dirs = nil,
  },
  ["folke/which-key.nvim"] = {
    plugins = {
      marks = true, -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      presets = {
        operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        motions = true, -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true, -- default bindings on <c-w>
        nav = true, -- misc bindings to work with windows
        z = true, -- bindings for folds, spelling and others prefixed with z
        g = true, -- bindings for prefixed with g
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 3, -- spacing between columns
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ "}, -- hide mapping boiler\
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for key maps that start with a native binding
      -- most people should not need to change this
      i = { "j", "k" },
      v = { "j", "k" },
    },
  },
}

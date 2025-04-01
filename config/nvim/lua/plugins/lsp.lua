return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      "nvim-lua/plenary.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      -- Mason setup
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        automatic_installation = true,
        ensure_installed = {
          "biome",
          "html",
          "cssls",
          "jsonls",
          "lua_ls",
          "tailwindcss",
          "pyright",
          "gopls",
        },
      })

      require("mason-tool-installer").setup({
        ensure_installed = {
          "stylua",
          "biome",
          "black",
          "pyright",
          "gopls",
        },
      })

      -- LSP Config
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      mason_lspconfig.setup_handlers({
        function(server_name)
          local config = { capabilities = capabilities }
          if server_name == "lua_ls" then
            config.settings = {
              Lua = { diagnostics = { globals = { "vim" } } },
            }
          end
          lspconfig[server_name].setup(config)
        end,
      })

      -- None-LS setup
      local none_ls = require("null-ls")
      local biome = none_ls.builtins.formatting.biome.with({
        command = "biome",
        args = { "format", "--stdin", "$FILENAME" },
      })
      none_ls.setup({ sources = { biome } })
    end,
  },
}

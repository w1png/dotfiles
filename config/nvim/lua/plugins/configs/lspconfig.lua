local present, lspconfig = pcall(require, "lspconfig")

if not present then
  return
end

require("base46").load_highlight "lsp"
require "nvchad_ui.lsp"

local M = {}
local utils = require "core.utils"

-- export on_attach & capabilities for custom lspconfigs

M.on_attach = function(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad_ui.signature").setup(client)
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

lspconfig.sumneko_lua.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.autopep8.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.bashls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.beautysh.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.cssls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.dockerls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.fixjson.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.goimports.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.golangci_lint.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.gopls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.html.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.jsonls.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.jsonlint.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.markdownlint.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.marksman.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.pyright.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.shellcheck.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.shfmt.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.stylua.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.tailwindcss.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.tsserver.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

-- omnisharp
lspconfig.omnisharp.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.arduino_language_server.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

lspconfig.clangd.setup {
  on_attach = M.on_attach,
  capabilities = M.capabilities,
}

return M
-- nvr --servername unity $@

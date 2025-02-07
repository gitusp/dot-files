return {
  { "neovim/nvim-lspconfig",
    dependencies = {
      { "yioneko/nvim-vtsls" },
      { "saghen/blink.cmp" },
    },
    config = function()
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig

      local capabilities = require('blink.cmp').get_lsp_capabilities()
      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({
        capabilities = capabilities
      })
      lspconfig.vtsls.setup({
        capabilities = capabilities
      })
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })
      lspconfig.prismals.setup({
        capabilities = capabilities
      })
      lspconfig.sqls.setup({
        capabilities = capabilities
      })
      lspconfig.eslint.setup({
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        capabilities = capabilities
      })
    end
  },
}

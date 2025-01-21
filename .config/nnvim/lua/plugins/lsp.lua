return {
  {
    "yioneko/nvim-vtsls",
    config = function()
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").vtsls.setup({})
    end
  },
}

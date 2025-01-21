return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "yioneko/nvim-vtsls" },
    },
    config = function()
      require("lspconfig.configs").vtsls = require("vtsls").lspconfig
      require("lspconfig").vtsls.setup({})
    end
  },
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope.nvim"},
    },
    event = "LspAttach",
    config = function()
      require('tiny-code-action').setup()

      vim.keymap.set("n", "<leader>ca", function()
        require("tiny-code-action").code_action()
      end, { desc = "Code Actions", noremap = true, silent = true })
    end
  }
}

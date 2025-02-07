return {
  {
    'projekt0n/github-nvim-theme',
      name = 'github-theme',
      lazy = false,
      priority = 1000,
      config = function()
        local spec = require('github-theme.spec').load('github_light')

        require('github-theme').setup({
          groups = {
            github_light = {
              DiffAdd = {
                bg = spec.diff.add,
              },
              DiffChange = {
                bg = spec.diff.change,
              },
              DiffDelete = {
                bg = spec.diff.delete,
              },
            },
          },
        })

        vim.cmd('colorscheme github_light')
      end,
  },
  {
    'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = true,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  },
}

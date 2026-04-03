return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "c",
          "lua",
          "vim",
          "vimdoc",
          "markdown",
          "markdown_inline",
          "typescript",
          "javascript",
          "json",
          "html",
          "css",
          "scss",
          "csv",
          "gitcommit",
          "gitignore",
          "prisma",
          "sql",
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
        matchup = {
          enable = true,
        }
      })
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
  {
    "andymass/vim-matchup",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}

return {
  'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    dependencies = {
      { "andymass/vim-matchup" }
    },
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
          additional_vim_regex_highlighting = false,
        },
        matchup = {
          enable = true,
        }
      })
    end
}

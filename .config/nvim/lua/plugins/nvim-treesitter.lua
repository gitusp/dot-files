return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "typescript",
        "tsx",
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
        "swift",
        "python",
        "bash",
        "yaml",
      }
      require('nvim-treesitter').install(ensure_installed)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if lang and pcall(vim.treesitter.start, args.buf, lang) then
            if lang == 'markdown' then
              vim.wo[0][0].foldexpr = 'v:lua.require("config.markdown_fold").foldexpr()'
              vim.wo[0][0].foldtext = 'v:lua.require("config.markdown_fold").foldtext()'
              vim.wo[0][0].foldlevel = 10
            else
              vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
              vim.wo[0][0].foldlevel = 99
            end
            vim.wo[0][0].foldmethod = 'expr'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
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

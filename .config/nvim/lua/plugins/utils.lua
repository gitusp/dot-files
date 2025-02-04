return {
  { "tpope/vim-repeat" },
  { "tpope/vim-unimpaired" },
  { "tpope/vim-projectionist" },
  { 'tpope/vim-abolish' },
  { 'tommcdo/vim-exchange' },
  { 'tpope/vim-dadbod' },
  { "tpope/vim-dotenv",
      config = function()
        vim.cmd("try | Dotenv .env.local | catch | endtry")
      end
  },
  { "cohama/lexima.vim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  { "motemen/vim-help-random" },
  {
    "oysandvik94/curl.nvim",
    cmd = { "CurlOpen" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = true,
  },
}

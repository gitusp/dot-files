return {
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
}

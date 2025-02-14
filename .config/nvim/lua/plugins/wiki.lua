return {
  "tlvince/vim-auto-commit",
  config = function()
    vim.cmd('autocmd BufWritePost ~/wiki/scratch/*.md call AutoCommit()')
  end
}

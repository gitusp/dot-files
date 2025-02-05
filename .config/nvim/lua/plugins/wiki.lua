return {
  "tlvince/vim-auto-commit",
  config = function()
    vim.cmd('autocmd BufWritePost ~/wiki/wiki/*.md call AutoCommit()')
  end
}

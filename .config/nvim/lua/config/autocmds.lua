vim.api.nvim_create_augroup('base', {})

vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'base',
  callback = function()
    vim.highlight.on_yank()
  end
})

-- Switch to ascii input (macSKK) when entering normal mode
vim.api.nvim_create_autocmd('ModeChanged', {
  group = 'base',
  pattern = '*:n',
  callback = function()
    vim.system({ 'macism', 'net.mtgto.inputmethod.macSKK.ascii' })
  end
})

vim.api.nvim_create_augroup('base', {})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'base',
  callback = function()
    vim.highlight.on_yank({ higroup='Visual', timeout=500 })
  end
})

-- HACK: Fire projectionist apply template to files created via oil.nvim
vim.api.nvim_create_autocmd('BufRead', {
  group = 'base',
  pattern = {'*'},
  callback = function()
    local lines = vim.fn.getline(1, '$')
    if #lines == 1 and lines[1] == '' then
      vim.cmd('doautocmd BufNewFile')
    end
  end
})

-- insertモード以外ではIMEを無効化する
vim.api.nvim_create_autocmd('InsertLeave', {
  desc = "Auto IME disabler",
  callback = function()
    vim.system({ "macism", "net.mtgto.inputmethod.macSKK.ascii" })
  end,
})

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

vim.api.nvim_create_autocmd('InsertEnter', {
  group = 'base',
  pattern = {'*'},
  callback = function()
    local out = vim.system({
      "./karabiner_cli",
      "--set-variables",
      '{"insert_mode":true}'
    }, {
      cwd = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin",
      detach = true
    })
  end
})

vim.api.nvim_create_autocmd('InsertLeave', {
  group = 'base',
  pattern = {'*'},
  callback = function()
    vim.system({
      "./karabiner_cli",
      "--set-variables",
      '{"insert_mode":false}'
    }, {
      cwd = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin",
      detach = true
    })
  end
})

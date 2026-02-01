vim.api.nvim_create_user_command('DailyScrum', function(opts)
  local days = tonumber(opts.args) or 0
  local filename = vim.fn.strftime("%Y-%m-%d", vim.fn.localtime() + days * 86400)
  vim.cmd('vnew')
  vim.cmd('e ~/vaults/scrums/' .. filename .. '.md')
  vim.keymap.set("n", "gq", "<cmd>q<cr>", { buffer = true })
end, { bang = true, nargs = '?' })

vim.api.nvim_create_user_command('Journal', function()
  vim.cmd('vnew')
  vim.cmd('e ~/vaults/journal/' .. vim.fn.strftime("%Y%m%dT%H%M%S") .. '.md')
  vim.keymap.set("n", "gq", "<cmd>q<cr>", { buffer = true })
end, { desc = 'Journal' })


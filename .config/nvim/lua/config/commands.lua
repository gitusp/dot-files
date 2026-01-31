vim.api.nvim_create_user_command('DailyScrum', function()
  local title = vim.fn.strftime("%Y-%m-%d")

  vim.cmd('vnew')
  vim.cmd('e ~/vaults/scrums/' .. title .. '.md')
  vim.keymap.set("n", "gq", "<cmd>q<cr>", { buffer = true })

  if vim.fn.filereadable(vim.fn.expand('%')) == 0 then
    local buf = vim.api.nvim_get_current_buf()
    vim.api.nvim_buf_set_lines(buf, 0, 1, false, {title, "===", "", ""})
    vim.cmd('normal! G')
    vim.cmd('w')
  end
end, { bang = true })

vim.api.nvim_create_user_command('Journal', function()
  vim.cmd('vnew')
  vim.cmd('e ~/vaults/journal/' .. vim.fn.strftime("%Y%m%dT%H%M%S") .. '.md')
  vim.keymap.set("n", "gq", "<cmd>q<cr>", { buffer = true })
end, { desc = 'Journal' })


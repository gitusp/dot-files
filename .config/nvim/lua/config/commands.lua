vim.api.nvim_create_user_command('Journal', function()
  vim.cmd('e ~/vaults/journal/' .. vim.fn.strftime("%Y%m%dT%H%M%S") .. '.md')
  vim.keymap.set("n", "gq", "<cmd>q<cr>", { buffer = true })
end, { desc = 'Journal' })


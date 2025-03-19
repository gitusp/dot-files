vim.api.nvim_create_augroup('github', {})
vim.api.nvim_create_autocmd("BufNewFile", {
  group = 'github',
  pattern = {"github://pulls"},
  callback = function()
    local buf = vim.api.nvim_get_current_buf()

    vim.api.nvim_buf_set_lines(buf, 0, 1, false, { 'loading...' })

    vim.api.nvim_set_option_value('filetype', 'github-pulls', { buf = buf })
    vim.api.nvim_set_option_value('buftype', 'nofile', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'hide', { buf = buf })
    vim.api.nvim_set_option_value('swapfile', false, { buf = buf })
    vim.api.nvim_set_option_value('readonly', true, { buf = buf })

    -- TODO: dot to populate commands

    vim.system({
      'gh', 'pr', 'list',
      '--json', 'number,title,author,headRefName,baseRefName',
      '--template', '{{range .}}#{{.number}} [origin/{{.baseRefName}}] <- [origin/{{.headRefName}}]\n{{.title}} by {{.author.login}}\n\n{{end}}'
    }, nil, function(result)
      vim.schedule(function()
        if result.code ~= 0 then
          vim.notify("Failed to get PR list", vim.log.levels.ERROR)
          return
        end

        vim.api.nvim_set_option_value('readonly', false, { buf = buf })
        vim.api.nvim_buf_set_lines(buf, 0, 1, false, vim.split(result.stdout:gsub('%s+$', ''), '\n'))
        vim.api.nvim_set_option_value('readonly', true, { buf = buf })
      end)
    end)
  end
})

vim.api.nvim_create_user_command('PRList', function()
  vim.cmd('vnew github://pulls')
end, { desc = 'List pull requests' })

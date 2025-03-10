vim.api.nvim_create_user_command('PRCheckout', function()
  require('fzf-lua').fzf_exec('gh pr list --json number,title,author --template \'{{range .}}{{tablerow .number .title .author.login}}{{end}}{{tablerender}}\'', {
    prompt = "PRs> ",
    actions = {
      ['default'] = function(selected)
        local parts = vim.split(selected[1], ' ')
        local pr_number = parts[1]

        vim.notify("Checking out PR " .. pr_number, vim.log.levels.INFO)
        checkout_result = vim.fn.system('gh pr checkout ' .. pr_number .. ' 2>&1')
        if vim.v.shell_error ~= 0 then
          vim.notify("Failed to checkout PR: " .. checkout_result, vim.log.levels.ERROR)
        end
      end
    },
    preview = "CLICOLOR_FORCE=1 gh pr view `echo {} | cut -d' ' -f1`",
  })
end, {})

vim.api.nvim_create_user_command('PRReview', function()
  vim.notify("Fetching PR information...", vim.log.levels.INFO)
  local gh_output = vim.fn.system('gh pr view --json baseRefName --jq .baseRefName 2>/dev/null')
  if vim.v.shell_error ~= 0 or gh_output == "" then
    vim.notify("Failed to get parent branch", vim.log.levels.ERROR)
    return
  end

  local parent_branch = "origin/" .. gh_output:gsub('%s+$', '')
  local merge_base = vim.fn.system('git merge-base ' .. parent_branch .. ' HEAD'):gsub('%s+$', '')
  vim.cmd('G difftool -y ' .. merge_base)
end, {})

vim.api.nvim_create_user_command('PRBrowse', function()
  local gh_output = vim.fn.system('gh pr view -w')
  if vim.v.shell_error ~= 0 then
    vim.fn.system('gh pr create -w')
  end
end, {})

vim.api.nvim_create_user_command('PRMerge', function()
  vim.fn.system('gh pr merge -d -m --admin')
end, {})

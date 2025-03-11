local function get_pr_number(selected)
  local parts = vim.split(selected[1], ' ')
  return parts[1]
end

local function pr_checkout(pr_number)
  vim.notify("Checking out PR " .. pr_number, vim.log.levels.INFO)
  checkout_result = vim.fn.system('gh pr checkout ' .. pr_number .. ' 2>&1')
  if vim.v.shell_error ~= 0 then
    error("Failed to checkout PR: " .. checkout_result)
  end
end

local function pr_review()
  vim.notify("Fetching PR information...", vim.log.levels.INFO)
  local gh_output = vim.fn.system('gh pr view --json baseRefName --jq .baseRefName 2>/dev/null')
  if vim.v.shell_error ~= 0 or gh_output == "" then
    vim.notify("Failed to get parent branch", vim.log.levels.ERROR)
    return
  end

  local parent_branch = "origin/" .. gh_output:gsub('%s+$', '')
  local merge_base = vim.fn.system('git merge-base ' .. parent_branch .. ' HEAD'):gsub('%s+$', '')
  vim.cmd('G difftool -y ' .. merge_base)
end

vim.api.nvim_create_user_command('PR', function()
  require('fzf-lua').fzf_exec('gh pr list --json number,title,author --template \'{{range .}}{{tablerow .number .title .author.login}}{{end}}{{tablerender}}\'', {
    prompt = "PRs> ",
    actions = {
      ['default'] = function(selected)
        local success, result = pcall(pr_checkout, get_pr_number(selected))
        if not success then
          vim.notify(result, vim.log.levels.ERROR)
        end
      end,
      ['ctrl-o'] = function(selected)
        vim.fn.system('gh pr view ' .. get_pr_number(selected) .. ' -w')
      end,
      ['ctrl-r'] = function(selected)
        local success, result = pcall(pr_checkout, get_pr_number(selected))
        if not success then
          vim.notify(result, vim.log.levels.ERROR)
        else
          pr_review()
        end
      end,
    },
    preview = "CLICOLOR_FORCE=1 gh pr view `echo {} | cut -d' ' -f1`",
  })
end, {})

vim.api.nvim_create_user_command('PRReview', pr_review, {})

vim.api.nvim_create_user_command('PRCreate', function()
  vim.fn.system('gh pr create -w')
end, {})

vim.api.nvim_create_user_command('PRMerge', function()
  vim.fn.system('gh pr merge -d -m --admin')
end, {})

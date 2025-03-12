local namespace = vim.api.nvim_create_namespace('pr-threads')

local function pr_checkout(pr_number)
  vim.notify("Checking out PR " .. pr_number, vim.log.levels.INFO)
  checkout_result = vim.fn.system('gh pr checkout ' .. pr_number .. ' 2>&1')
  if vim.v.shell_error ~= 0 then
    error("Failed to checkout PR: " .. checkout_result)
  end
end

local function pr_review()
  vim.cmd('PRThreads')

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

vim.api.nvim_create_user_command('PRThreads', function()
  vim.notify("Fetching PR comments...", vim.log.levels.INFO)
  
  -- Get current PR number asynchronously
  vim.fn.jobstart('gh pr view --json number --jq .number 2>/dev/null', {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if #data == 0 or (data[1] == "" and #data == 1) then
        vim.notify("Failed to get PR number. Are you on a PR branch?", vim.log.levels.ERROR)
        return
      end
      
      local pr_number = data[1]:gsub('%s+$', '')
      
      -- Fetch PR review comments using REST API asynchronously
      vim.fn.jobstart('gh api repos/:owner/:repo/pulls/' .. pr_number .. '/comments --paginate', {
        stdout_buffered = true,
        on_stdout = function(_, comments_data)
          if #comments_data == 0 or (comments_data[1] == "" and #comments_data == 1) then
            vim.notify("Failed to fetch PR comments", vim.log.levels.ERROR)
            return
          end
          
          local comments_json = table.concat(comments_data, '\n')
          
          local comments = vim.fn.json_decode(comments_json)
          if #comments == 0 then
            vim.notify("No comments found in this PR", vim.log.levels.INFO)
            return
          end
          
          -- Group comments by path and line (to simulate threads)
          local threads = {}
          for _, comment in ipairs(comments) do
            if comment.in_reply_to_id then
              table.insert(threads[comment.in_reply_to_id].reply_comments, comment)
            else
              threads[comment.id] = {
                comment = comment,
                reply_comments = {}
              }
            end
          end
          
          local function build_diagnostic(thread)
            local comments = {thread.comment}
            for _, reply_comment in ipairs(thread.reply_comments) do
              table.insert(comments, reply_comment)
            end

            local messages = {}
            for _, comment in ipairs(comments) do
              table.insert(messages, comment.user.login .. " (" .. comment.created_at .. "):\n" .. comment.body)
            end

            local diag = {
              bufnr = vim.fn.bufadd(thread.comment.path),
              col = 0,
              message = table.concat(messages, "\n\n"),
              severity = vim.diagnostic.severity.INFO,
              source = "PR Comment"
            }

            if type(thread.comment.start_line) == "number" then
              diag.lnum = thread.comment.start_line - 1
              diag.end_lnum = thread.comment.line - 1
            else
              diag.lnum = thread.comment.line - 1
            end

            return diag
          end
          
          local buf_diagnostics = {}
        
          for _, thread in pairs(threads) do
            local diag = build_diagnostic(thread)
            
            -- Group diagnostics by buffer
            if not buf_diagnostics[diag.bufnr] then
              buf_diagnostics[diag.bufnr] = {}
            end
            table.insert(buf_diagnostics[diag.bufnr], diag)
          end

          for bufnr, diagnostics in pairs(buf_diagnostics) do
            vim.diagnostic.set(namespace, bufnr, diagnostics, {})
          end

          vim.notify("Loaded all the threads into diagnostics", vim.log.levels.INFO)
        end,
        on_stderr = function(_, data)
          if #data > 0 and (data[1] ~= "" or #data > 1) then
            vim.notify("Error fetching PR comments: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
          end
        end,
        on_exit = function(_, exit_code)
          if exit_code ~= 0 then
            vim.notify("Failed to fetch PR comments: exit code " .. exit_code, vim.log.levels.ERROR)
          end
        end,
      })
    end,
    on_stderr = function(_, data)
      if #data > 0 and (data[1] ~= "" or #data > 1) then
        vim.notify("Error getting PR number: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code ~= 0 then
        vim.notify("Failed to get PR number: exit code " .. exit_code, vim.log.levels.ERROR)
      end
    end,
  })
end, {})

vim.api.nvim_create_user_command('PR', function()
  local function get_pr_number(selected)
    local parts = vim.split(selected[1], ' ')
    return parts[1]
  end

  require('fzf-lua').fzf_exec('gh pr list --json number,title,author --template \'{{range .}}{{tablerow .number .title .author.login}}{{end}}{{tablerender}}\'', {
    prompt = "PRs> ",
    actions = {
      ['default'] = function(selected)
        vim.fn.system('gh pr view ' .. get_pr_number(selected) .. ' -w')
      end,
      ['ctrl-o'] = function(selected)
        local success, result = pcall(pr_checkout, get_pr_number(selected))
        if not success then
          vim.notify(result, vim.log.levels.ERROR)
        end
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

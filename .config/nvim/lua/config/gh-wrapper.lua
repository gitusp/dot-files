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

local function build_diagnostic(base_path, thread)
  local messages = {}
  for _, comment in ipairs(thread.comments.nodes) do
    table.insert(messages, comment.author.login .. " (" .. comment.createdAt .. "):\n" .. comment.body)
  end

  local diag = {
    bufnr = vim.fn.bufadd(base_path .. '/' .. thread.path),
    col = 0,
    message = table.concat(messages, "\n\n"),
    severity = vim.diagnostic.severity.INFO,
    source = "PR Comment"
  }

  if type(thread.startLine) == "number" then
    diag.lnum = thread.startLine - 1
    diag.end_lnum = thread.line - 1
  else
    diag.lnum = thread.line - 1
  end

  return diag
end

vim.api.nvim_create_user_command('PRThreads', function()
  vim.notify("Fetching PR threads...", vim.log.levels.INFO)
  
  vim.fn.jobstart('gh pr view --json headRefName --jq .headRefName 2>/dev/null', {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if #data == 0 or (data[1] == "" and #data == 1) then
        vim.notify("Failed to get PR number. Are you on a PR branch?", vim.log.levels.ERROR)
        return
      end
      
      local headRefName = data[1]:gsub('%s+$', '')

      local threads = {}

      local function load_threads(threads, after)
        local after_arg = after and ' -F after=\'' .. after .. '\'' or ''
        vim.fn.jobstart(
          'gh api graphql -F owner=\'{owner}\' -F name=\'{repo}\' -F headRefName=\'' .. headRefName .. '\'' .. after_arg .. ' -f query=\'' ..
          '  query($name: String!, $owner: String!, $headRefName: String!, $after: String) {' ..
          '    repository(owner: $owner, name: $name) {' ..
          '      pullRequests(first: 1, headRefName: $headRefName) {' ..
          '        nodes {' ..
          '          reviewThreads(first: 100, after: $after) {' ..
          '            nodes {' ..
          '              path' ..
          '              line' ..
          '              startLine' ..
          '              isResolved' ..
          '              isOutdated' ..
          '              path' ..
          '              comments(first: 100) {' ..
          '                nodes {' ..
          '                  body' ..
          '                  author {' ..
          '                    login' ..
          '                  }' ..
          '                  createdAt' ..
          '                }' ..
          '              }' ..
          '            }' ..
          '            pageInfo {' ..
          '              endCursor' ..
          '              hasNextPage' ..
          '            }' ..
          '          }' ..
          '        }' ..
          '      }' ..
          '    }' ..
          '  }\'',
          {
            stdout_buffered = true,
            on_stdout = function(_, repository_data)
              if #repository_data == 0 or (repository_data[1] == "" and #repository_data == 1) then
                vim.notify("Failed to fetch PR threads", vim.log.levels.ERROR)
                return
              end
              
              local repository_json = table.concat(repository_data, '\n')
              local decoded = vim.fn.json_decode(repository_json)

              if #decoded.data.repository.pullRequests.nodes == 0 then
                vim.notify("PR not found", vim.log.levels.ERROR)
                return
              end

              if #decoded.data.repository.pullRequests.nodes[1].reviewThreads.nodes == 0 then
                vim.notify("No threads found in this PR", vim.log.levels.INFO)
                return
              end

              for _, thread in ipairs(decoded.data.repository.pullRequests.nodes[1].reviewThreads.nodes) do
                table.insert(threads, thread)
              end
              
              if decoded.data.repository.pullRequests.nodes[1].reviewThreads.pageInfo.hasNextPage then
                load_threads(threads, decoded.data.repository.pullRequests.nodes[1].reviewThreads.pageInfo.endCursor)
              else
                local base_path = vim.fn.trim(vim.fn.system('git rev-parse --show-toplevel')):gsub('%s+$', '')
              
                local buf_diagnostics = {}
                for _, thread in pairs(threads) do
                  local collapsed = thread.isResolved or thread.isOutdated
                  if (type(thread.startLine) == "number" or type(thread.line) == "number") and not collapsed then
                    local diag = build_diagnostic(base_path, thread)
                    
                    -- Group diagnostics by buffer
                    if not buf_diagnostics[diag.bufnr] then
                      buf_diagnostics[diag.bufnr] = {}
                    end
                    table.insert(buf_diagnostics[diag.bufnr], diag)
                  end
                end

                for bufnr, diagnostics in pairs(buf_diagnostics) do
                  vim.diagnostic.set(namespace, bufnr, diagnostics, {})
                end

                vim.notify("Loaded all the threads into diagnostics", vim.log.levels.INFO)
              end
            end,
            on_stderr = function(_, data)
              if #data > 0 and (data[1] ~= "" or #data > 1) then
                vim.notify("Error fetching PR threads: " .. table.concat(data, "\n"), vim.log.levels.ERROR)
              end
            end,
            on_exit = function(_, exit_code)
              if exit_code ~= 0 then
                vim.notify("Failed to fetch PR threads: exit code " .. exit_code, vim.log.levels.ERROR)
              end
            end,
          }
        )
      end
      
      load_threads({})
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

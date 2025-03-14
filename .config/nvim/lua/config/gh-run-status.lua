local M = {}

local cache = {}

local function get_repo_info(path, cb)
  local repo_url_code
  local repo_url
  local branch_code
  local branch

  local function next()
    if repo_url and branch then
      cb({ repo_url = repo_url, branch = branch })
    else
      cb(nil)
    end
  end

  vim.system(
    { "git", "config", "--get", "remote.origin.url" },
    { cwd = path },
    function(obj)
      repo_url_code = obj.code
      repo_url = obj.stdout:gsub("%s+$", "")

      if type(branch_code) == "number" then
        next()
      end
    end
  )

  vim.system(
    { "git", "rev-parse", "--abbrev-ref", "HEAD" },
    { cwd = path },
    function(obj)
      branch_code = obj.code
      branch = obj.stdout:gsub("%s+$", "")

      if type(repo_url_code) == "number" then
        next()
      end
    end
  )
end

local function check_github_status(path, branch, cb)
  vim.system(
    { "gh", "run", "list", "--branch", branch, "--limit", "1", "--json", "status,conclusion" },
    { cwd = path },
    function(obj)
      if obj.code ~= 0 then
        cb(nil)
        return
      end

      local ok, parsed = pcall(vim.json.decode, obj.stdout)
      if not ok or not parsed or #parsed == 0 then
        cb(nil)
        return
      end

      cb(parsed[1])
    end
  )
end

local function watch(path)
  get_repo_info(
    path,
    function(result)
      local function flush()
        cache[path].status = nil
        cache[path].conclusion = nil
      end

      local function next()
        cache[path].accessed = false

        local timer = vim.uv.new_timer()
        timer:start(10000, 0, function()
          if cache[path].accessed then
            watch(path)
          else
            cache[path] = nil
          end
        end)
      end

      if result then
        if result.repo_url:match("github.com") then
          check_github_status(path, result.branch, function(status_result)
            if status_result then
              cache[path].status = status_result.status
              cache[path].conclusion = status_result.conclusion
            end
            next()
          end)
        else
          flush()
          next()
        end
      else
        flush()
        next()
      end
    end
  )
end

function M.get_status(path)
  if cache[path] then
    cache[path].accessed = true
  else
    cache[path] = {
      status = nil,
      conclusion = nil,
      accessed = true,
    }
    watch(path)
  end

  return cache[path].status, cache[path].conclusion
end

return M

return {
  generator = function(search, cb)
    if #vim.fs.find(".git", { upward = true, path = search.dir }) == 0 then
      return cb({})
    end
    cb({
      {
        name = "git push",
        builder = function()
          return { cmd = "git push" }
        end,
      },
      {
        name = "git pull",
        builder = function()
          return { cmd = "git pull" }
        end,
      },
      {
        name = "git fetch",
        builder = function()
          return { cmd = "git fetch" }
        end,
      },
      {
        name = "gh pr create",
        builder = function(params)
          local cmd = "gh pr create -f"
          if params.base ~= "" then
            cmd = cmd .. " --base " .. params.base
          end
          return { cmd = cmd }
        end,
        params = {
          base = { type = "string", default = "", optional = true, desc = "Base branch" },
        },
      },
      {
        name = "gh pr merge",
        builder = function()
          return { cmd = "gh pr merge -d -m --admin" }
        end,
      },
      {
        name = "gh pr view",
        builder = function() return { cmd = "gh pr view --web" } end,
      },
    })
  end,
}

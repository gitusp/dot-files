return {
  generator = function(search, cb)
    if #vim.fs.find(".git", { upward = true, path = search.dir }) == 0 then
      return cb({})
    end
    cb({
      {
        name = "claude commit",
        builder = function()
          local prompt = "Commit staged changes only. No Co-Authored-By, no mention of Claude, no email addresses."
          return {
            cmd = { "claude", "-p", prompt, "--permission-mode", "acceptEdits" },
          }
        end,
      },
      {
        name = "gh pr create",
        builder = function() return { cmd = "gh pr create -f" } end,
      },
      {
        name = "gh pr merge",
        builder = function() return { cmd = "gh pr merge -d -m --admin" } end,
      },
      {
        name = "gh pr view",
        builder = function() return { cmd = "gh pr view --web" } end,
      },
      {
        name = "gh repo view",
        builder = function() return { cmd = "gh repo view --web" } end,
      },
    })
  end,
}

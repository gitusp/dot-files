return {
  generator = function(search, cb)
    if #vim.fs.find("tsconfig.json", { upward = true, path = search.dir }) == 0 then
      return cb({})
    end
    cb({
      {
        name = "tsc",
        builder = function()
          return {
            cmd = { "npx", "tsc", "--noEmit" },
            components = {
              { "on_output_quickfix", open = true },
              "default",
            },
          }
        end,
      },
    })
  end,
}

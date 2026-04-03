return {
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
  condition = {
    callback = function()
      return vim.fn.filereadable("tsconfig.json") == 1
    end,
  },
}

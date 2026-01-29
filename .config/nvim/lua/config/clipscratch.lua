vim.api.nvim_create_user_command("ClipScratch", function()
  vim.cmd("tabnew")
  local buf = vim.api.nvim_get_current_buf()
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"

  -- クリップボードの内容で初期化
  local clipboard = vim.fn.getreg("+")
  local lines = vim.split(clipboard, "\n", { plain = true })
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  vim.api.nvim_create_autocmd("BufUnload", {
    buffer = buf,
    once = true,
    callback = function(args)
      local content = vim.api.nvim_buf_get_lines(args.buf, 0, -1, false)
      vim.fn.setreg("+", table.concat(content, "\n"))
    end,
  })
end, {})

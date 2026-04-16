return {
  dir = "resize-mode",
  virtual = true,
  keys = {
    { "<C-w><", desc = "Resize mode (narrower)" },
    { "<C-w>>", desc = "Resize mode (wider)" },
    { "<C-w>-", desc = "Resize mode (shorter)" },
    { "<C-w>+", desc = "Resize mode (taller)" },
  },
  config = function()
    local function resize_mode(keys, direction)
      local count = vim.v.count1
      vim.cmd(keys.cmd_prefix .. (direction > 0 and "+" or "-") .. count)
      local pending = 0
      vim.api.nvim_echo({{"-- RESIZE --", "ModeMsg"}}, false, {})
      while true do
        local ok, key = pcall(vim.fn.getcharstr)
        if not ok then break end
        if key:match("^%d$") then
          pending = pending * 10 + tonumber(key)
        elseif key == keys.minus or key == keys.plus then
          local n = pending > 0 and pending or 1
          pending = 0
          vim.cmd(keys.cmd_prefix .. (key == keys.plus and "+" or "-") .. n)
        else
          vim.api.nvim_feedkeys(key, "m", true)
          break
        end
        vim.cmd("redraw")
      end
      vim.api.nvim_echo({{"", ""}}, false, {})
    end

    local horizontal = {
      cmd_prefix = "vertical resize ",
      minus = "<", plus = ">",
    }
    local vertical = {
      cmd_prefix = "resize ",
      minus = "-", plus = "+",
    }

    vim.keymap.set("n", "<C-w><", function() resize_mode(horizontal, -1) end, { desc = "Resize mode (narrower)" })
    vim.keymap.set("n", "<C-w>>", function() resize_mode(horizontal, 1) end, { desc = "Resize mode (wider)" })
    vim.keymap.set("n", "<C-w>-", function() resize_mode(vertical, -1) end, { desc = "Resize mode (shorter)" })
    vim.keymap.set("n", "<C-w>+", function() resize_mode(vertical, 1) end, { desc = "Resize mode (taller)" })
  end,
}

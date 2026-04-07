local function focus_claude_insert()
  local bufnr = require("claudecode.terminal").get_active_terminal_bufnr()
  if not bufnr then
    return
  end
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == bufnr then
      vim.api.nvim_set_current_win(win)
      vim.cmd("startinsert")
      return
    end
  end
end

return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    terminal = {
      snacks_win_opts = {
        keys = {
          term_normal = false,
        },
        on_buf = function(self)
          -- Disable the auto_insert BufEnter autocmd that snacks.terminal sets up.
          -- Deferred because the autocmd is registered after Snacks.win() returns.
          vim.schedule(function()
            vim.api.nvim_clear_autocmds({
              event = "BufEnter",
              group = self.augroup,
              buffer = self.buf,
            })
          end)
        end,
      },
    },
  },
  keys = {
    { "<c-\\>", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
    {
      "<c-'>",
      function()
        vim.cmd("ClaudeCodeAdd %")
        focus_claude_insert()
      end,
      desc = "Add current buffer",
    },
    {
      "<c-'>",
      function()
        vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
        vim.cmd("'<,'>ClaudeCodeSend")
        focus_claude_insert()
      end,
      mode = "x",
      desc = "Send to Claude",
    },
    {
      "<c-'>",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
  },
}

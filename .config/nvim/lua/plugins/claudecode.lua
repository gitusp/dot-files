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
    { "<c-'>", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
    { "<c-'>", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
    {
      "<c-'>",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
  },
}

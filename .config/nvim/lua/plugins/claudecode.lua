return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  config = true,
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

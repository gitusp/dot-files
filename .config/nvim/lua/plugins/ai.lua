return {
  {
    "github/copilot.vim",
    init = function()
      vim.g.copilot_filetypes = {
        markdown = false,
        ['copilot-chat'] = false,
      }
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {
      model = 'claude-3.7-sonnet',
    },
  },
}

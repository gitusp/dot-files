return {
  { "github/copilot.vim",
      init = function()
        vim.g.copilot_filetypes = { markdown = false }
      end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {},
  }
}

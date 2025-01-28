return {
  {
    "rachartier/tiny-code-action.nvim",
    dependencies = {
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope.nvim"},
    },
    event = "LspAttach",
    config = function()
      require('tiny-code-action').setup()

      vim.api.nvim_create_user_command(
        'CodeAction',
        function()
          require("tiny-code-action").code_action()
        end,
        { desc = 'LSP code actions' }
      )
    end
  }
}

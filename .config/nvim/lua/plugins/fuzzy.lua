return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require('fzf-lua')

      vim.api.nvim_create_user_command('FzfFiles', fzf.files, { desc = 'FZF files' })
      vim.api.nvim_create_user_command('FzfOldfiles', fzf.oldfiles, { desc = 'FZF oldfiles' })
      vim.api.nvim_create_user_command('FzfBlines', fzf.blines, { desc = 'FZF current buffer lines' })
      vim.api.nvim_create_user_command('FzfGrepCword', fzf.grep_cword, { desc = 'FZF search word under cursor' })
      vim.api.nvim_create_user_command('FzfLiveGrepNative', fzf.live_grep_native, { desc = 'FZF live grep current project' })
      vim.api.nvim_create_user_command('FzfLspReferences', fzf.lsp_references, { desc = 'FZF LSP references' })
      vim.api.nvim_create_user_command('FzfLspDefinitions', fzf.lsp_definitions, { desc = 'FZF LSP definitions' })
      vim.api.nvim_create_user_command('FzfLspDeclarations', fzf.lsp_declarations, { desc = 'FZF LSP declarations' })
      vim.api.nvim_create_user_command('FzfLspTypedefs', fzf.lsp_typedefs, { desc = 'FZF LSP type definitions' })
      vim.api.nvim_create_user_command('FzfLspImplementations', fzf.lsp_implementations, { desc = 'FZF LSP implementations' })
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
  }
}


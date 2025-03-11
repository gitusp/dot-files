return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "lambdalisue/vim-mr" },
    },
    config = function()
      local fzf = require('fzf-lua')

      local function wrap_zoxide_action(action)
        return function(selected, opts)
          selected[1] = selected[1]:match("[^\t]+$")
          action(selected, opts)
          require("oil.actions").cd.callback({ scope = "win" })
        end
      end

      fzf.setup({
        files = {
          fd_opts = fzf.defaults.files.fd_opts .. [[ --type d]],
        },
        zoxide = {
          actions = {
            ["enter"] = wrap_zoxide_action(fzf.actions.file_edit),
            ["ctrl-s"] = wrap_zoxide_action(fzf.actions.file_split),
            ["ctrl-v"] = wrap_zoxide_action(fzf.actions.file_vsplit),
            ["ctrl-t"] = wrap_zoxide_action(fzf.actions.file_tabedit),
          },
        },
      })

      vim.api.nvim_create_user_command('FzfFiles', fzf.files, { desc = 'FZF files' })
      vim.api.nvim_create_user_command('FzfLgrepCurbuf', fzf.lgrep_curbuf, { desc = 'FZF live grep current buffer' })
      vim.api.nvim_create_user_command('FzfGrepCword', fzf.grep_cword, { desc = 'FZF search word under cursor' })
      vim.api.nvim_create_user_command('FzfLiveGrepNative', fzf.live_grep_native, { desc = 'FZF live grep current project' })
      vim.api.nvim_create_user_command('FzfLspReferences', fzf.lsp_references, { desc = 'FZF LSP references' })
      vim.api.nvim_create_user_command('FzfLspDefinitions', fzf.lsp_definitions, { desc = 'FZF LSP definitions' })
      vim.api.nvim_create_user_command('FzfLspDeclarations', fzf.lsp_declarations, { desc = 'FZF LSP declarations' })
      vim.api.nvim_create_user_command('FzfLspTypedefs', fzf.lsp_typedefs, { desc = 'FZF LSP type definitions' })
      vim.api.nvim_create_user_command('FzfLspImplementations', fzf.lsp_implementations, { desc = 'FZF LSP implementations' })
      vim.api.nvim_create_user_command('FzfZoxide', fzf.zoxide, { desc = 'FZF zoxide' })

      --- Thanks: https://zenn.dev/uga_rosa/articles/318bba82c53a1d
      local function mrx(mode)
        fzf.fzf_exec(
          function(cb)
            local list = vim.fn[("mr#%s#list"):format(mode)]()
            local filtered = vim.fn["mr#filter"](list, vim.fn.getcwd())
            for _, path in ipairs(filtered) do
              cb(fzf.make_entry.file(path, { file_icons = true, color_icons = true }))
            end
            cb()
          end,
          {
            prompt = ("%s> "):format(mode:upper()),
            actions = {
              ["enter"] = fzf.actions.file_edit_or_qf,
              ["ctrl-s"] = fzf.actions.file_split,
              ["ctrl-v"] = fzf.actions.file_vsplit,
              ["ctrl-t"] = fzf.actions.file_tabedit,
              ["alt-q"] = fzf.actions.file_sel_to_qf,
              ["alt-Q"] = fzf.actions.file_sel_to_ll,
            },
            previewer = "builtin",
            fzf_opts = {
              ["--no-sort"] = "",
              ["--multi"] = true,
            },
          }
        )
      end

      vim.api.nvim_create_user_command('FzfMru', function() mrx("mru") end, { desc = 'FZF MRU' })
      vim.api.nvim_create_user_command('FzfMrr', function() mrx("mrr") end, { desc = 'FZF MRR' })
      vim.api.nvim_create_user_command('FzfMrw', function() mrx("mrw") end, { desc = 'FZF MRW' })
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
}


return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
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

      fzf.register_ui_select()
      fzf.setup({
        files = {
          fd_opts = fzf.defaults.files.fd_opts .. [[ --type d]],
        },
        grep = {
          actions = {
            ["alt-w"] = function(_, opts)
              opts.toggle_flag = "--word-regexp"
              fzf.actions.toggle_flag(_, opts)
            end,
          },
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
      vim.api.nvim_create_user_command('FzfGrepCurbuf', fzf.grep_curbuf, { desc = 'FZF grep current buffer' })
      vim.api.nvim_create_user_command('FzfGrepProject', fzf.grep_project, { desc = 'FZF grep project' })
      vim.api.nvim_create_user_command('FzfDiagnosticsWorkspace', fzf.diagnostics_workspace, { desc = 'FZF diagnostics workspace' })
      vim.api.nvim_create_user_command('FzfLspReferences', fzf.lsp_references, { desc = 'FZF LSP references' })
      vim.api.nvim_create_user_command('FzfLspDefinitions', fzf.lsp_definitions, { desc = 'FZF LSP definitions' })
      vim.api.nvim_create_user_command('FzfLspDeclarations', fzf.lsp_declarations, { desc = 'FZF LSP declarations' })
      vim.api.nvim_create_user_command('FzfLspTypedefs', fzf.lsp_typedefs, { desc = 'FZF LSP type definitions' })
      vim.api.nvim_create_user_command('FzfLspImplementations', fzf.lsp_implementations, { desc = 'FZF LSP implementations' })
      vim.api.nvim_create_user_command('FzfZoxide', fzf.zoxide, { desc = 'FZF zoxide' })
      vim.api.nvim_create_user_command('FzfBuffers', fzf.buffers, { desc = 'FZF buffers' })

      vim.api.nvim_create_user_command('FzfMru', function() fzf.oldfiles({ cwd_only = true }) end, { desc = 'FZF MRU' })

      --
      -- s mappings (grep operator)
      --
      local function grep(search)
        fzf.grep({
          search = search,
          rg_opts = '--multiline ' .. fzf.defaults.grep.rg_opts,
        })
      end

      local function setup_opfunc()
        local old_func = vim.go.operatorfunc

        local type_to_mode = { char = 'v', line = 'V', block = '\22' }

        _G.opfunc_search_range = function(type)
          local lines = vim.fn.getregion(vim.fn.getpos("'["), vim.fn.getpos("']"), { type = type_to_mode[type] })
          grep(vim.trim(table.concat(lines, "\n")))

          vim.go.operatorfunc = old_func
          _G.opfunc_search_range = nil
        end

        vim.go.operatorfunc = 'v:lua.opfunc_search_range'
      end

      vim.keymap.set("n", "s", function() setup_opfunc(); return "g@" end, { expr = true, desc = 'FZF operator' })
      vim.keymap.set("n", "ss", function() setup_opfunc(); return "g@_" end, { expr = true, desc = 'FZF operator - line' })
      vim.keymap.set("n", "S", fzf.grep_project, { desc = 'FZF grep project' })
      vim.keymap.set('x', 's', function() grep(fzf.utils.get_visual_selection()) end, { desc = 'FZF grep visual' })
    end
  },
}


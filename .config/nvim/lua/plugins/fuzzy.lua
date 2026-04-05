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
      -- gs, gS mappings (grep operator)
      --
      local function grep(word, search)
        local opts = { search = search }
        local rg_opts = '--multiline ' .. fzf.defaults.grep.rg_opts
        if word then
          rg_opts = '--word-regexp ' .. rg_opts
        end
        opts.rg_opts = rg_opts
        fzf.grep(opts)
      end

      local function create_search_visual(word)
        return function()
          local search = fzf.utils.get_visual_selection()
          grep(word, search)
        end
      end

      local function setup_opfunc(word)
        local old_func = vim.go.operatorfunc

        local type_to_mode = { char = 'v', line = 'V', block = '\22' }

        _G.opfunc_search_range = function(type)
          local lines = vim.fn.getregion(vim.fn.getpos("'["), vim.fn.getpos("']"), { type = type_to_mode[type] })
          local search = vim.trim(table.concat(lines, "\n"))
          grep(word, search)

          vim.go.operatorfunc = old_func
          _G.opfunc_search_range = nil
        end

        vim.go.operatorfunc = 'v:lua.opfunc_search_range'
      end

      vim.keymap.set("n", "gs", function() setup_opfunc(false); return "g@" end, { expr = true, desc = 'FZF operator' })
      vim.keymap.set("n", "gss", function() setup_opfunc(false); return "g@_" end, { expr = true, desc = 'FZF operator - line' })
      vim.keymap.set("n", "gS", function() setup_opfunc(true); return "g@" end, { expr = true, desc = 'FZF operator - word' })
      vim.keymap.set("n", "gSS", function() setup_opfunc(true); return "g@_" end, { expr = true, desc = 'FZF operator - word line' })
      vim.keymap.set('x', 'gs', create_search_visual(false), { desc = 'FZF grep visual' })
      vim.keymap.set('x', 'gS', create_search_visual(true), { desc = 'FZF grep visual - word' })
    end
  },
}


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
      -- ys, yS mappings (grep operator)
      --
      local function grep(word, search)
        if word then
          search = [[\b]] .. fzf.utils.rg_escape(search) .. [[\b]]
          fzf.grep({ search = search, no_esc = true })
        else
          fzf.grep({ search = search })
        end
      end

      local function create_search_visual(word)
        return function()
          local search = fzf.utils.get_visual_selection()
          grep(word, search)
        end
      end

      local function create_search_opfunc(word)
        return function()
          local old_func = vim.go.operatorfunc

          _G.opfunc_search_range = function()
            local start = vim.api.nvim_buf_get_mark(0, '[')
            local finish = vim.api.nvim_buf_get_mark(0, ']')

            local search
            if start[1] == finish[1] then
              local line = vim.fn.getline(start[1])
              search = string.sub(line, start[2] + 1, finish[2] + 1)
            else
              local lines = vim.fn.getline(start[1], finish[1])
              search = table.concat(lines, "\n")
            end
            grep(word, search)

            vim.go.operatorfunc = old_func
            _G.opfunc_search_range = nil
          end

          vim.go.operatorfunc = 'v:lua.opfunc_search_range'

          local key = vim.fn.getcharstr()
          if key == 's' then
            vim.go.operatorfunc = old_func
            _G.opfunc_search_range = nil
            fzf.grep_project()
          else
            vim.api.nvim_feedkeys('g@' .. key, 'n', false)
          end
        end
      end

      vim.keymap.set("n", "ys", create_search_opfunc(false), { desc = 'FZF operator' })
      vim.keymap.set("n", "yS", create_search_opfunc(true), { desc = 'FZF operator - word' })
      vim.keymap.set('x', 'ys', create_search_visual(false), { desc = 'FZF grep visual' })
      vim.keymap.set('x', 'yS', create_search_visual(true), { desc = 'FZF grep visual - word' })
    end
  },
}


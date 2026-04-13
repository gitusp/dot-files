return {
  {
    "ibhagwan/fzf-lua",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
    },
    config = function()
      local fzf = require('fzf-lua')

      local function open_action(vimcmd)
        vimcmd = vimcmd or "edit"
        return function(selected, opts)
          if #selected == 1 and vim.fn.isdirectory(fzf.path.entry_to_file(selected[1]).path) == 1 then
            vim.cmd(vimcmd .. " " .. vim.fn.fnameescape(fzf.path.entry_to_file(selected[1]).path))
          else
            fzf.actions.file_edit_or_qf(selected, opts)
          end
        end
      end

      local function wrap_zoxide_action(vimcmd)
        return function(selected)
          if selected[1] then
            selected[1] = selected[1]:match("[^\t]+$")
            open_action(vimcmd)(selected)
            require("oil.actions").cd.callback({ scope = "win" })
          end
        end
      end

      fzf.register_ui_select()
      fzf.setup({
        files = {
          fd_opts = fzf.defaults.files.fd_opts .. [[ --type d]],
          actions = { ["default"] = open_action() },
        },
        grep = {
          rg_opts = "--hidden -g '!.git' --multiline " .. fzf.defaults.grep.rg_opts,
          actions = {
            ["alt-w"] = function(_, opts)
              opts.toggle_flag = "--word-regexp"
              fzf.actions.toggle_flag(_, opts)
            end,
          },
        },
        zoxide = {
          actions = {
            ["enter"] = wrap_zoxide_action(),
            ["ctrl-s"] = wrap_zoxide_action("split"),
            ["ctrl-v"] = wrap_zoxide_action("vsplit"),
            ["ctrl-t"] = wrap_zoxide_action("tabedit"),
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

      -- DocBase
      do
        local initial_per_page = 20
        local per_page = 100

        vim.api.nvim_create_user_command('FzfDocBase', function()
          local domain = vim.env.DOCBASE_DOMAIN
          local token = vim.env.DOCBASE_TOKEN
          if not domain or domain == '' or not token or token == '' then
            vim.notify('DOCBASE_DOMAIN and DOCBASE_TOKEN must be set', vim.log.levels.ERROR)
            return
          end

          local base = vim.fn.fnameescape('docbase:' .. domain .. ':')
          local posts_by_id = {}
          local stored_fzf_cb = nil

          local builtin = require('fzf-lua.previewer.builtin')
          local DocBasePreviewer = builtin.base:extend()
          DocBasePreviewer._ctor = function() return DocBasePreviewer end

          function DocBasePreviewer:populate_preview_buf(entry_str)
            local id = entry_str:match('^(%d+)')
            local p = id and posts_by_id[id] or nil
            local tmpbuf = self:get_tmp_buffer()
            local lines = {}
            if p then
              lines[1] = '# ' .. (p.title or '')
              lines[2] = ''
              for _, line in ipairs(vim.split(p.body or '', '\n', { plain = true })) do
                lines[#lines + 1] = (line:gsub('\r', ''))
              end
            end
            vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, false, lines)
            vim.bo[tmpbuf].filetype = 'markdown'
            self:set_preview_buf(tmpbuf)
          end

          local function make_entry(p)
            local id = tostring(p.id)
            posts_by_id[id] = p
            local body_flat = (p.body or ''):gsub('[\r\n\t]', ' ')
            return id .. '\t' .. (p.title or '') .. '\t\x1b[2m' .. body_flat .. '\x1b[0m'
          end

          local function fetch_page_async(page, size, callback)
            local url = string.format(
              'https://api.docbase.io/teams/%s/posts?per_page=%d&page=%d', domain, size, page)
            vim.system(
              { 'curl', '-sS', '-H', 'X-DocBaseToken: ' .. token, url },
              { text = true },
              function(obj)
                if obj.code ~= 0 then
                  vim.schedule(function()
                    vim.notify('DocBase API request failed: ' .. (obj.stderr or ''), vim.log.levels.ERROR)
                  end)
                  callback(nil)
                  return
                end
                local ok, data = pcall(vim.json.decode, obj.stdout or '')
                if not ok or type(data) ~= 'table' then
                  vim.schedule(function()
                    vim.notify('DocBase API: invalid response', vim.log.levels.ERROR)
                  end)
                  callback(nil)
                  return
                end
                if data.error then
                  vim.schedule(function()
                    local msg = data.error
                    if data.messages then
                      msg = msg .. ': ' .. table.concat(data.messages, ', ')
                    end
                    vim.notify('DocBase API: ' .. msg, vim.log.levels.ERROR)
                  end)
                  callback(nil)
                  return
                end
                callback(data.posts)
              end
            )
          end

          local function fetch_all(fzf_cb, page, skip)
            skip = skip or 0
            fetch_page_async(page, per_page, function(posts)
              if not posts or #posts == 0 then
                fzf_cb(nil)
                return
              end
              vim.schedule(function()
                for i, p in ipairs(posts) do
                  if i > skip then
                    fzf_cb(make_entry(p))
                  end
                end
                if #posts < per_page then
                  fzf_cb(nil)
                else
                  fetch_all(fzf_cb, page + 1)
                end
              end)
            end)
          end

          local fzf_opts = {
            prompt = 'DocBase> ',
            previewer = DocBasePreviewer,
            fzf_opts = {
              ['--ansi'] = '',
              ['--multi'] = '',
              ['--delimiter'] = '\\t',
              ['--with-nth'] = '2..',
              ['--header'] = 'ctrl-l: load all | tab: multi-select',
            },
            actions = {
              ['default'] = function(selected)
                if not selected then return end
                if #selected == 1 then
                  local id = selected[1]:match('^(%d+)')
                  if id then vim.cmd('edit ' .. base .. id) end
                else
                  local items = {}
                  for _, s in ipairs(selected) do
                    local id, title = s:match('^(%d+)\t(.+)')
                    if id then table.insert(items, { filename = base .. id, text = title or '' }) end
                  end
                  vim.fn.setqflist(items)
                  vim.cmd('copen')
                end
              end,
            },
          }

          fzf_opts.actions['ctrl-l'] = {
            fn = function()
              if stored_fzf_cb then
                fetch_all(stored_fzf_cb, 1, initial_per_page)
              end
            end,
            field_index = false,
            exec_silent = true,
          }

          fzf.fzf_exec(function(fzf_cb)
            stored_fzf_cb = fzf_cb
            fetch_page_async(1, initial_per_page, function(posts)
              if not posts or #posts == 0 then
                fzf_cb(nil)
                return
              end
              vim.schedule(function()
                for _, p in ipairs(posts) do
                  fzf_cb(make_entry(p))
                end
              end)
            end)
          end, fzf_opts)
        end, { desc = 'FZF DocBase' })
      end

      --
      -- s mappings (grep operator)
      --
      local function grep(search)
        fzf.grep({
          search = search,
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


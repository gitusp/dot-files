return {
  { "neovim/nvim-lspconfig",
    dependencies = {
      { "yioneko/nvim-vtsls" },
      { "saghen/blink.cmp" },
    },
    config = function()
      -- Set capabilities globally for all LSP servers
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      vim.lsp.config('*', {
        capabilities = capabilities
      })

      -- Global LspAttach autocmd for server-specific behaviors
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local bufnr = args.buf

          -- ESLint: Auto-fix on save
          if client.name == 'eslint' then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end

          -- Biome: Auto-format on save
          if client.name == 'biome' then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ async = false })
              end,
            })
          end
        end,
      })

      -- Configure vtsls
      vim.lsp.config('vtsls', require("vtsls").lspconfig)

      -- Configure simple servers
      local simple_servers = {
        'cssmodules_ls',
        'clangd',
        'jsonls',
        'prismals',
        'sqls',
        'sourcekit',
      }

      for _, server in ipairs(simple_servers) do
        vim.lsp.enable(server)
      end

      -- Configure lua_ls with custom settings
      vim.lsp.config('lua_ls', {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      })

      -- Configure biome with custom settings
      vim.lsp.config('biome', {
        cmd = { "npx", "biome", "lsp-proxy" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "json", "jsonc" },
        root_markers = { "biome.json", "package.json" },
      })

      -- Enable servers with custom configurations
      vim.lsp.enable('vtsls')
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('eslint')
      vim.lsp.enable('biome')
    end
  },
}

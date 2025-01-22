return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fc', builtin.grep_string, { desc = 'Telescope search current word' })
        vim.keymap.set('n', '<leader>fr', builtin.lsp_references, { desc = 'Telescope LSP references' })
        vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, { desc = 'Telescope LSP definitions' })
        vim.keymap.set('n', '<leader>fx', builtin.diagnostics, { desc = 'Telescope LSP diagnostics' })
        vim.keymap.set('n', '<leader>fi', builtin.lsp_implementations, { desc = 'Telescope LSP implementations' })
        vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, { desc = 'Telescope LSP type definitions' })
        vim.keymap.set('n', '<leader>fs', builtin.lsp_workspace_symbols, { desc = 'Telescope LSP workspace symbols' })
        vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Telescope old files' })
        vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find, { desc = 'Telescope current buffer fuzzy find' })
        vim.keymap.set('n', '<leader>fe', builtin.resume, { desc = 'Telescope resume' })
        vim.keymap.set('n', '<leader>fp', builtin.pickers, { desc = 'Telescope pickers' })
        vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope keymaps' })
      end
    }

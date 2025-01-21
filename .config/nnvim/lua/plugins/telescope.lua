return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
        vim.keymap.set('n', '<leader>fs', builtin.grep_string, { desc = 'Telescope selection search' })

        -- TODO: LSP Settings

        vim.keymap.set('n', '<c-p>', '<leader>ff', { remap = true })
        vim.keymap.set('n', 'gl', '<leader>fg', { remap = true })
        vim.keymap.set('n', '<c-8>', '<leader>fs', { remap = true })
      end
    }

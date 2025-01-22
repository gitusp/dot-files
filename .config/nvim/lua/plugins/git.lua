return {
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "rbong/vim-flog" },
  { "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buffer = bufnr
              vim.keymap.set(mode, l, r, opts)
            end

            -- Navigation
            map('n', ']c', function()
              if vim.wo.diff then
                vim.cmd.normal({']c', bang = true})
              else
                gitsigns.nav_hunk('next')
              end
            end, { desc = "Git next hunk" })

            map('n', '[c', function()
              if vim.wo.diff then
                vim.cmd.normal({'[c', bang = true})
              else
                gitsigns.nav_hunk('prev')
              end
            end, { desc = "Git previous hunk" })

            -- Actions
            map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Git stage hunk" })
            map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Git reset hunk" })

            map('v', '<leader>hs', function()
              gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end, { desc = "Git stage hunk (visual)" })

            map('v', '<leader>hr', function()
              gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end, { desc = "Git reset hunk (visual)" })

            map('n', '<leader>hS', gitsigns.stage_buffer, { desc = "Git stage buffer" })
            map('n', '<leader>hR', gitsigns.reset_buffer, { desc = "Git reset buffer" })
            map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Git preview hunk" })
            map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Git preview hunk inline" })

            map('n', '<leader>hb', function()
              gitsigns.blame_line({ full = true })
            end, { desc = "Git blame line" })

            map('n', '<leader>hd', gitsigns.diffthis, { desc = "Git diff this" })

            map('n', '<leader>hD', function()
              gitsigns.diffthis('~')
            end, { desc = "Git diff this (against ~)" })

            map('n', '<leader>hQ', function() gitsigns.setqflist('all') end, { desc = "Git set quickfix list (all)" })
            map('n', '<leader>hq', gitsigns.setqflist, { desc = "Git set quickfix list" })

            -- Toggles
            map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Git toggle current line blame" })
            map('n', '<leader>td', gitsigns.toggle_deleted, { desc = "Git toggle deleted" })
            map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "Git toggle word diff" })

            -- Text object
            map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Git select hunk" })
          end
        })
      end
  },
}

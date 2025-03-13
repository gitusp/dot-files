return {
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  {
    "rbong/vim-flog",
    lazy = true,
    cmd = { "Flog", "Flogsplit", "Floggit" },
    dependencies = {
      "tpope/vim-fugitive",
    },
  },
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
          end
        })
      end
  },
  {
    "gitusp/pbrowse.nvim",
    lazy = true,
    cmd = { "PBrowse" },
  },
  {
    "gitusp/pr-review.nvim",
    lazy = true,
    cmd = { "PRBrowse", "PRReview", "PRFetchThreads", "PRShowThreads", "PRHideThreads", "PRToggleThreads" },
  },
}

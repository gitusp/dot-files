return {
  { "tpope/vim-fugitive" },
  { "lewis6991/gitsigns.nvim",
      config = function()
        require("gitsigns").setup({
          on_attach = function(bufnr)
            local gitsigns = require('gitsigns')

            local function map(mode, l, r, opts)
              opts = opts or {}
              opts.buf = bufnr
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
    "isakbm/gitgraph.nvim",
    lazy = true,
    cmd = "GitGraph",
    opts = {
      hooks = {
        on_select_commit = function(commit)
          vim.cmd(":vert Git show " .. commit.hash)
        end,
        on_select_range_commit = function(from, to)
          vim.cmd(":vert Git diff " .. from.hash .. " " .. to.hash)
        end,
      },
    },
    config = function(_, opts)
      require("gitgraph").setup(opts)
      vim.api.nvim_create_user_command("GitGraph", function()
        require("gitgraph").draw({}, { all = true, max_count = 5000 })
      end, {})
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "gitgraph",
        callback = function(ev)
          vim.keymap.set("n", ".", function()
            local row = vim.api.nvim_win_get_cursor(0)[1]
            local line = vim.api.nvim_get_current_line()
            local target
            if row % 2 == 0 then
              line = vim.api.nvim_buf_get_lines(0, row - 2, row - 1, false)[1]
              target = line:match("%x%x%x%x%x%x%x+")
            else
              local col = vim.api.nvim_win_get_cursor(0)[2]
              local paren = line:match(".*(%b())")
              local ps = paren and line:find(paren, 1, true)
              local in_parens = ps and col >= ps - 1 and col <= ps - 2 + #paren
              target = in_parens and vim.fn.expand("<cWORD>"):gsub("[()]", "") or line:match("%x%x%x%x%x%x%x+")
            end
            if target and target ~= "" then
              local keys = vim.api.nvim_replace_termcodes(": " .. target .. "<Home>Git ", true, false, true)
              vim.api.nvim_feedkeys(keys, "n", false)
            end
          end, { buffer = ev.buf, desc = "Git command with ref" })
        end,
      })
    end,
  },
}

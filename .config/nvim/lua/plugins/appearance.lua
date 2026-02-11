return {
  {
    'projekt0n/github-nvim-theme',
      name = 'github-theme',
      lazy = false,
      priority = 1000,
      config = function()
        local is_kitty = vim.env.WEZNOTE_INSTANCE ~= nil
        local theme = is_kitty and 'github_dark' or 'github_light'
        local spec = require('github-theme.spec').load(theme)
        local opts = {
          DiffAdd = { bg = spec.diff.add },
          DiffChange = { bg = spec.diff.change },
          DiffDelete = { bg = spec.diff.delete },
        }

        require('github-theme').setup({
          groups = {
            github_light = opts,
            github_dark_dimmed = opts,
          },
        })

        vim.cmd('colorscheme ' .. theme)
      end,
  },
  {
    'nvim-lualine/lualine.nvim',
      dependencies = {
        'nvim-tree/nvim-web-devicons',
        'gitusp/gh-run-status.nvim',
      },
      config = function()
        local get_gh_run_status = require('gh-run-status').create_getter()
        local function gh_run_status()
          local status, conclusion = get_gh_run_status(vim.fn.getcwd())
          if not status then
            return ""
          end

          -- See https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/collaborating-on-repositories-with-code-quality-features/about-status-checks#check-statuses-and-conclusions
          if status == "completed" then
            if conclusion == "success" or conclusion == "neutral" or conclusion == "skipped" then
              return "✓"
            else
              return "✗"
            end
          elseif status == "expected" or status == "in_progress" or status == "pending" or status == "queued" or status == "requested" or status == "waiting" then
            return "⏱"
          else
            return "✗"
          end
        end

        require('lualine').setup({
          sections = {
            lualine_b = { 'branch', gh_run_status, 'diff', 'diagnostics' },
          }
        })
      end,
  },
}

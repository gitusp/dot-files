return {
  {
    'projekt0n/github-nvim-theme',
      name = 'github-theme',
      lazy = false,
      priority = 1000,
      config = function()
        local spec = require('github-theme.spec').load('github_light')

        require('github-theme').setup({
          groups = {
            github_light = {
              DiffAdd = {
                bg = spec.diff.add,
              },
              DiffChange = {
                bg = spec.diff.change,
              },
              DiffDelete = {
                bg = spec.diff.delete,
              },
            },
          },
        })

        vim.cmd('colorscheme github_light')
      end,
  },
  {
    'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('lualine').setup({
          sections = {
            lualine_b = {
              'branch',
              function()
                local status, conclusion = require('config.gh-run-status').get(vim.fn.getcwd())
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
              end,
              'diff',
              'diagnostics'
            },
          }
        })
      end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
      vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
    end
  },
}

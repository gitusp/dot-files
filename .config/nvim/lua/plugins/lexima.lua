return {
  {
    "cohama/lexima.vim",
    config = function()
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '[',
          input = '[ ] ',
          at = '^\\s*- \\%#',
          filetype = 'markdown'
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs>',
          at = '^- \\%#$',
          filetype = 'markdown',
          priority = 2
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><bs>- ',
          at = '^\\s\\+- \\%#$',
          filetype = 'markdown',
          priority = 2,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><bs><bs><bs><bs>',
          at = '^- \\[ ] \\%#$',
          filetype = 'markdown',
          priority = 2
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><bs><bs><bs><bs><bs>- [ ] ',
          at = '^\\s\\+- \\[ ] \\%#$',
          filetype = 'markdown',
          priority = 2,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<cr>- [ ] ',
          at = '^\\s*- \\[[ xX]] .*\\%#',
          filetype = 'markdown',
          priority = 1,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<cr>- ',
          at = '^\\s*- .*\\%#',
          filetype = 'markdown'
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<bs>',
          input = '<bs><bs><bs><bs>',
          at = '^\\s*- \\[ ] \\%#',
          filetype = 'markdown',
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><c-w><bs>\\1. ',
          at = '^\\s\\+\\(\\d\\+\\)\\. \\%#$',
          filetype = 'markdown',
          with_submatch = true,
          priority = 1,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><c-w>',
          at = '^\\d\\+\\. \\%#$',
          filetype = 'markdown',
          priority = 1,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<cr>\\1<esc><c-a>a. ',
          at = '^\\s*\\(\\d\\+\\)\\. .*\\%#',
          filetype = 'markdown',
          with_submatch = true,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<',
          input_after = '>',
          filetype = {'typescriptreact', 'javascriptreact', 'markdown', 'html', 'xml'}
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '>',
          input_after = '</>',
          leave = '>',
          at = '<\\%#>',
          filetype = {'typescriptreact', 'javascriptreact'},
          priority = 1,
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '>',
          input_after = '</\\1>',
          leave = '>',
          at = '<\\(\\(\\w\\|\\.\\)\\+\\)[^/>]*\\%#>',
          with_submatch = true,
          filetype = {'typescriptreact', 'javascriptreact', 'markdown', 'html', 'xml'},
          priority = 1,
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '>',
          leave = '>',
          at = '\\%#>',
          filetype = {'typescriptreact', 'javascriptreact', 'markdown', 'html', 'xml'}
        }
      })
    end,
  },
}

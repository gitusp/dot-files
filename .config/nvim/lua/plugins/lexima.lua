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
          at = '^\\s*- \\[ ] .*\\%#',
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
          filetype = {'typescriptreact', 'javascriptreact'}
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '>',
          input_after = '</\\1>',
          leave = '>',
          at = '<\\(\\(\\w\\|\\.\\)\\+\\)[^/>]*\\%#>',
          with_submatch = true,
          filetype = {'typescriptreact', 'javascriptreact', 'markdown', 'html', 'xml'}
        }
      })
    end,
  },
}

return {
  {
    "cohama/lexima.vim",
    config = function()
      local markdown_like = { 'markdown', 'docbase' }
      local markup_like = { 'typescriptreact', 'javascriptreact', 'markdown', 'docbase', 'html', 'xml' }

      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '[',
          input = '[ ] ',
          at = '^\\s*- \\%#',
          filetype = markdown_like
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs>',
          at = '^- \\%#$',
          filetype = markdown_like,
          priority = 2
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><bs>- ',
          at = '^\\s\\+- \\%#$',
          filetype = markdown_like,
          priority = 2,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><bs><bs><bs><bs>',
          at = '^- \\[ ] \\%#$',
          filetype = markdown_like,
          priority = 2
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><bs><bs><bs><bs><bs>- [ ] ',
          at = '^\\s\\+- \\[ ] \\%#$',
          filetype = markdown_like,
          priority = 2,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<cr>- [ ] ',
          at = '^\\s*- \\[[ xX]] .*\\%#',
          filetype = markdown_like,
          priority = 1,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<cr>- ',
          at = '^\\s*- .*\\%#',
          filetype = markdown_like
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<bs>',
          input = '<bs><bs><bs><bs>',
          at = '^\\s*- \\[ ] \\%#',
          filetype = markdown_like,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><c-w><bs>\\1. ',
          at = '^\\s\\+\\(\\d\\+\\)\\. \\%#$',
          filetype = markdown_like,
          with_submatch = true,
          priority = 1,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<bs><bs><c-w>',
          at = '^\\d\\+\\. \\%#$',
          filetype = markdown_like,
          priority = 1,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<cr>',
          input = '<cr>\\1<esc><c-a>a. ',
          at = '^\\s*\\(\\d\\+\\)\\. .*\\%#',
          filetype = markdown_like,
          with_submatch = true,
        },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<',
          input_after = '>',
          filetype = markup_like
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
          char = '=',
          delete = 1,
          at = '<\\%#>',
          filetype = {'typescriptreact', 'javascriptreact'},
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = ' ',
          delete = 1,
          at = '<\\%#>',
          filetype = {'typescriptreact', 'javascriptreact'},
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '>',
          input_after = '</\\1>',
          leave = '>',
          at = '<\\(\\(\\w\\|\\.\\)\\+\\)[^/>]*\\%#>',
          with_submatch = true,
          filetype = markup_like,
          priority = 1,
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '>',
          leave = '>',
          at = '\\%#>',
          filetype = markup_like
        }
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        {
          char = '<bs>',
          input = '<bs><bs><bs>',
          at = '\\s*// \\%#',
          filetype = {'typescriptreact', 'javascriptreact', 'typescript', 'javascript'},
        }
      })
    end,
  },
}

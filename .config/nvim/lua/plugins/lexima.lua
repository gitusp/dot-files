return {
  {
    "cohama/lexima.vim",
    init = function()
      vim.g.lexima_no_default_rules = 1
    end,
    config = function()
      local markdown_like = { 'markdown', 'docbase' }

      -- Markdown: `- ` + `[` → `- [ ] `
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '[', input = '[ ] ', at = '^\\s*- \\%#', filetype = markdown_like },
      })

      -- Markdown: Enter on empty `- ` removes it (top-level / indented)
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<bs><bs>', at = '^- \\%#$', filetype = markdown_like, priority = 2 },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<bs><bs><bs>- ', at = '^\\s\\+- \\%#$', filetype = markdown_like, priority = 2 },
      })

      -- Markdown: Enter on empty `- [ ] ` removes it (top-level / indented)
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<bs><bs><bs><bs><bs><bs>', at = '^- \\[ ] \\%#$', filetype = markdown_like, priority = 2 },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<bs><bs><bs><bs><bs><bs><bs>- [ ] ', at = '^\\s\\+- \\[ ] \\%#$', filetype = markdown_like, priority = 2 },
      })

      -- Markdown: Enter after checkbox line continues with `- [ ] `
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<cr>- [ ] ', at = '^\\s*- \\[[ xX]] .*\\%#', filetype = markdown_like, priority = 1 },
      })

      -- Markdown: Enter after list item continues with `- `
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<cr>- ', at = '^\\s*- .*\\%#', filetype = markdown_like },
      })

      -- Markdown: Backspace on `- [ ] ` removes checkbox
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<bs>', input = '<bs><bs><bs><bs>', at = '^\\s*- \\[ ] \\%#', filetype = markdown_like },
      })

      -- Markdown: Numbered list - dedent on empty (indented / top-level)
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<bs><bs><c-w><bs>\\1. ', at = '^\\s\\+\\(\\d\\+\\)\\. \\%#$', filetype = markdown_like, with_submatch = true, priority = 1 },
      })
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<bs><bs><c-w>', at = '^\\d\\+\\. \\%#$', filetype = markdown_like, priority = 1 },
      })

      -- Markdown: Numbered list - auto-increment on Enter
      vim.api.nvim_call_function("lexima#add_rule", {
        { char = '<cr>', input = '<cr>\\1<esc><c-a>a. ', at = '^\\s*\\(\\d\\+\\)\\. .*\\%#', filetype = markdown_like, with_submatch = true },
      })
    end,
  },
}

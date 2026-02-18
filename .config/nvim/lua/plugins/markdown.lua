return {
  {
    'dhruvasagar/vim-table-mode',
    init = function()
      vim.g.table_mode_disable_mappings = 1
      vim.g.table_mode_disable_tableize_mappings = 1
    end,
  },
  {
    'kyoh86/vim-docbase',
    init = function()
      local domain = vim.env.DOCBASE_DOMAIN
      local token = vim.env.DOCBASE_TOKEN

      if domain ~= nil and domain ~= "" and token ~= nil and token ~= "" then
        vim.g.docbase = {
          domains = {
            {
              domain = domain,
              token = token,
            },
          },
        }
      end
    end,
  },
  {
    'kyoh86/vim-metarw-docbase',
    dependencies = {
      'kana/vim-metarw',
      'kyoh86/vim-docbase',
    },
  },
}

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
    config = function()
      vim.api.nvim_create_user_command('DocBaseNew', function()
        local domain = vim.env.DOCBASE_DOMAIN
        if domain then
          vim.cmd('e docbase:' .. domain .. ':new')
        else
          vim.notify('DOCBASE_DOMAIN is not set', vim.log.levels.ERROR)
        end
      end, {})
    end,
  },
}

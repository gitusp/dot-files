return {
  {
    name = 'docbase',
    dir = vim.fn.stdpath('config'),
    event = {
      'BufReadPre *.docbase.md',
      'BufNewFile *.docbase.md',
    },
    config = function()
      require('docbase').setup()
    end,
  },
}

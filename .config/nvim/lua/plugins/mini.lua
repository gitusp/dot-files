return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
      require("mini.operators").setup({
        exchange = { prefix = "cx" },
        evaluate = { prefix = "g=" },
        multiply = { prefix = "" },
        replace  = { prefix = "" },
        sort     = { prefix = "" },
      })
      vim.keymap.del("x", "cx")
      vim.keymap.set("x", "X", "<cmd>lua MiniOperators.exchange('visual')<cr>")
      require("mini.surround").setup({
        mappings = {
          add = 'ys',
          delete = 'ds',
          find = '',
          find_left = '',
          highlight = '',
          replace = 'cs',
          update_n_lines = '',
          suffix_last = '',
          suffix_next = '',
        },
      })
      vim.keymap.del('x', 'ys')
      vim.keymap.set('x', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true, desc = 'Surround visual' })
      local gen_ai_spec = require("mini.extra").gen_ai_spec
      require("mini.ai").setup({
        custom_textobjects = {
          g = gen_ai_spec.buffer(),
        },
      })
      require("mini.indentscope").setup()
    end,
  },
}

return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.bracketed").setup({
        buffer     = { suffix = "" },
        comment    = { suffix = "" },
        conflict   = { suffix = "" },
        diagnostic = { suffix = "" },
        file       = { suffix = "f" },
        indent     = { suffix = "" },
        jump       = { suffix = "" },
        location   = { suffix = "" },
        oldfile    = { suffix = "" },
        quickfix   = { suffix = "" },
        treesitter = { suffix = "" },
        undo       = { suffix = "" },
        window     = { suffix = "" },
        yank       = { suffix = "" },
      })
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
      require("mini.surround").setup()
      local gen_ai_spec = require("mini.extra").gen_ai_spec
      require("mini.ai").setup({
        mappings = {
          around_last = '',
          inside_last = '',
        },
        custom_textobjects = {
          l = gen_ai_spec.line(),
          g = gen_ai_spec.buffer(),
        },
      })
      require("mini.indentscope").setup()
    end,
  },
}

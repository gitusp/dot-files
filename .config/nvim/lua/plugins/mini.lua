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
      require("mini.ai").setup()
    end,
  },
}

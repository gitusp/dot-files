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
    end,
  },
}

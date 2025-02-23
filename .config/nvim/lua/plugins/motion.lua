return {
  { "haya14busa/vim-edgemotion",
      keys = {
        { "<c-j>", "<Plug>(edgemotion-j)", mode = { "n", "x" } },
        { "<c-k>", "<Plug>(edgemotion-k)", mode = { "n", "x" } },
      },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        char = {
          enabled = false,
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  }
}

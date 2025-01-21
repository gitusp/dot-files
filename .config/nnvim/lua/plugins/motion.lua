return {
  { "haya14busa/vim-edgemotion",
      keys = {
        { "<c-j>", "<Plug>(edgemotion-j)", mode = { "n", "x" } },
        { "<c-k>", "<Plug>(edgemotion-k)", mode = { "n", "x" } },
      },
  },
  {
    "ggandor/leap.nvim",
    lazy = false,
    config = function()
      require('leap').create_default_mappings()
    end
  }
}

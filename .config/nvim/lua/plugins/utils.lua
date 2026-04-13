return {
  { 'tpope/vim-dadbod' },
  { 'tpope/vim-dotenv',
      config = function()
        vim.cmd("try | Dotenv .env.local | catch | endtry")
      end
  },
  {
    "folke/todo-comments.nvim",
    opts = {}
  },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      require("oil").setup({
        delete_to_trash = true,
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        keymaps = {
          ["cd"] = { "actions.cd", opts = { scope = "win" }, mode = "n" },
          ["."] = { "actions.open_cmdline", opts = { shorten_path = true } },
          ["gy"] = { "actions.yank_entry", opts = { modify = ":~:." } },
          ["g~"] = {
            callback = function() require("oil").open("~") end,
            desc = "Open home directory",
          },
        },
      })
    end
  },
  {
    'stevearc/quicker.nvim',
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    config = function()
      require("quicker").setup({
        keys = {
          {
            ">",
            function()
              require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
            end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function()
              require("quicker").collapse()
            end,
            desc = "Collapse quickfix context",
          },
        },
      })
    end,
  },
  {
    'stevearc/overseer.nvim',
    opts = {},
    config = true,
  },
  { "lukasx999/syncwd.nvim" },
}

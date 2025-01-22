return {
  'dmmulroy/tsc.nvim',
    config = function()
      require('tsc').setup()
      vim.keymap.set("n", "<leader>ct", "<cmd>TSC<cr>", { desc = "Compile TypeScript" })
    end
}

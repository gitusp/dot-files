require("config.lazy")

vim.o.mouse = ""

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit"
vim.o.wildignorecase = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.lazyredraw = true
vim.o.shortmess = vim.o.shortmess .. 'I'
vim.o.showtabline = 0
vim.o.signcolumn = "yes"
vim.o.diffopt = vim.o.diffopt .. ',iwhite'

vim.o.undofile = true

vim.api.nvim_create_augroup( 'lua', {} )
vim.api.nvim_create_autocmd( 'TextYankPost', {
  group = 'lua',
  callback = function()
    vim.highlight.on_yank({ higroup='Visual', timeout=500 })
  end
})

-- keymaps

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR><C-L>")

vim.keymap.set('n', '<c-p>', '<leader>ff', { remap = true })
vim.keymap.set('n', '<c-8>', '<leader>fc', { remap = true })
vim.keymap.set('n', 'gd', '<leader>fd', { remap = true })
vim.keymap.set('n', 'gl', '<leader>fg', { remap = true })
vim.keymap.set('n', 'gr', '<leader>fr', { remap = true })

vim.keymap.set("n", "<c-l>", "<leader>ca", { remap = true })

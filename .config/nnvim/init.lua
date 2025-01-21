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

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<CR><C-L>")


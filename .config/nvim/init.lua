require("config.lazy")

--
-- Base Configuration
--
vim.o.mouse = ""

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "nosplit"
vim.o.wildignorecase = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smarttab = true

vim.o.lazyredraw = true
vim.o.shortmess = vim.o.shortmess .. 'I'
vim.o.showtabline = 0
vim.o.signcolumn = "yes"
vim.o.diffopt = vim.o.diffopt .. ',iwhite'
vim.o.diffopt = vim.o.diffopt .. ',algorithm:histogram'
vim.o.diffopt = vim.o.diffopt .. ',vertical'

vim.o.undofile = true

--
-- Appearance
--
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN] = "",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})

-- Highlight on yank
vim.api.nvim_create_augroup( 'base', {} )
vim.api.nvim_create_autocmd( 'TextYankPost', {
  group = 'base',
  callback = function()
    vim.highlight.on_yank({ higroup='Visual', timeout=500 })
  end
})

--
-- Custom Commands
--
vim.api.nvim_create_user_command('Scratch', function()
  vim.cmd('vnew')
  vim.cmd('e ~/vaults/scratch/index.md')
end, { desc = 'Scratch' })
vim.cmd("function! Journal() abort\n" .. "return strftime('%Y-%m-%d.md')\n" .. "endfunction")
vim.api.nvim_create_user_command('Rename', vim.lsp.buf.rename, { desc = 'LSP rename' })
vim.api.nvim_create_user_command('Format', vim.lsp.buf.format, { desc = 'LSP format' })

--
-- Keymaps
--
-- Single key mappings
vim.keymap.set("n", "<c-l>", "<cmd>nohlsearch<CR><C-L>")
vim.keymap.set("n", "Y", "y$")
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "_", "@:")
vim.keymap.set("n", "s", "<cmd>w<cr>", { desc = "Save" })
vim.keymap.set("n", "S", "<cmd>wa<cr>", { desc = "Save All" })
vim.keymap.set("x", "Y", '"+y')
vim.keymap.set("n", "<c-q>", "<cmd>CodeAction<cr>")
vim.keymap.set("n", "<c-/>", "<cmd>FzfLgrepCurbuf<cr>")

-- Single key mappings with leader
vim.keymap.set("n", "<leader>s", "<cmd>Scratch<cr>", { desc = "Util scratch" })
vim.keymap.set('n', '<leader>g', '<cmd>vert G<cr>', { desc = 'Git status' })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, { desc = "LSP Diagnostics" })
vim.keymap.set("n", "<leader>m", "<cmd>TSC<cr>", { desc = "Compile TypeScript" })
vim.keymap.set("n", "<leader>f", "<cmd>FzfLua<cr>", { desc = "FZF builtin" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>:", function() require('telescope.builtin').commands() end, { desc = 'Telescope commands' })
vim.keymap.set("n", "<leader>?", function() require('telescope.builtin').keymaps({ default_text = "<Space>" }) end, { desc = "Telescope leader key mappings" })
vim.keymap.set("n", "<localleader>?", function() require('telescope.builtin').keymaps({ default_text = "\\" }) end, { desc = "Telescope localleader key mappings" })

-- TODO shortcuts
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- Fzf shortcuts
vim.keymap.set('n', '<c-p>', '<cmd>FzfFiles<cr>', { desc = 'FZF files' })
vim.keymap.set('n', '<c-n>', '<cmd>FzfMru<cr>', { desc = 'FZF MRU' })
vim.keymap.set('n', '<c-8>', '<cmd>FzfGrepCword<cr>', { desc = 'FZF search word under cursor' })
vim.keymap.set('n', 'gs', '<cmd>FzfLiveGrepNative<cr>', { desc = 'FZF live grep' })
vim.keymap.set('n', 'gd', '<cmd>FzfLspDefinitions<cr>', { desc = 'FZF LSP definitions' })
vim.keymap.set('n', 'gr', '<cmd>FzfLspReferences<cr>', { desc = 'FZF LSP references' })
vim.keymap.set('n', 'gy', '<cmd>FzfLspTypedefs<cr>', { desc = 'FZF LSP type definitions' })
vim.keymap.set('n', 'gl', '<cmd>FzfLspImplementations<cr>', { desc = 'FZF LSP implementations' })

-- emmet
vim.keymap.set("i", "<c-x><cr>", "<plug>(emmet-expand-abbr)", { silent = true, desc = "Emmet expand abbr" })

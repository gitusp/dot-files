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

vim.o.undofile = true

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
vim.api.nvim_create_user_command('Wiki', function()
  vim.cmd('e ~/wiki/wiki/index.md')
end, { desc = 'Open Wiki' })

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

-- Single key mappings with leader
vim.keymap.set("n", "<leader>w", "<cmd>Wiki<cr>", { desc = "Util open wiki" })

-- TODO shortcuts
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- telescope shortcuts
vim.keymap.set('n', '<c-p>', '<leader>ff', { remap = true })
vim.keymap.set('n', '<c-8>', '<leader>fc', { remap = true })
vim.keymap.set('n', 'gd', '<leader>fd', { remap = true, desc = 'Telescope LSP definitions' })
vim.keymap.set('n', 'gl', '<leader>fl', { remap = true, desc = 'Telescope live grep' })
vim.keymap.set('n', 'gr', '<leader>fr', { remap = true, desc = 'Telescope LSP references' })
vim.keymap.set('n', 'gs', '<leader>fs', { remap = true, desc = 'Telescope LSP workspace symbols' })
vim.keymap.set('n', 'gi', '<leader>fi', { remap = true, desc = 'Telescope LSP implementations' })
vim.keymap.set('n', 'gy', '<leader>fy', { remap = true, desc = 'Telescope LSP type definitions' })
vim.keymap.set('n', 'gx', '<leader>fx', { remap = true, desc = 'Telescope LSP diagnostics' })
vim.keymap.set("n", "<leader>?", function() require('telescope.builtin').keymaps({ default_text = "<Space>" }) end, { desc = "Telescope leader keymaps" })

-- Git shortcuts
vim.keymap.set('n', '<leader>gs', '<cmd>vert G<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gp', '<cmd>G push -u origin head<cr>', { desc = 'Git push' })
vim.keymap.set('n', '<leader>gt', '<cmd>Flog<cr>', { desc = 'Git tree' })

-- AI features
vim.keymap.set('n', '<leader>ai', '<cmd>CopilotChat<cr>', { desc = 'AI Interactive Chat' })
vim.keymap.set('n', '<leader>ac', '<cmd>CopilotChatCommit<cr>', { remap = true, desc = 'AI Commit Message' })
vim.keymap.set('n', '<leader>af', '<cmd>CopilotChatFix<cr>', { remap = true, desc = 'AI Fix' })

-- LSP features
vim.keymap.set("n", "<c-q>", "<leader>ca", { remap = true })
vim.keymap.set("n", "<leader>cr", "<cmd>LspRestart<cr>", { desc = "LSP Restart" })
vim.keymap.set("n", "<leader>cn", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "LSP Format" })
vim.keymap.set("n", "<c-n>", "<leader>cn", { remap = true })

-- emmet
vim.keymap.set("i", "<c-x><cr>", "<plug>(emmet-expand-abbr)", { silent = true, desc = "Emmet expand abbr" })

-- motions
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

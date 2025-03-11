require("config.lazy")
require("config.gh-wrapper")

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
-- https://wezterm.org/shell-integration.html
vim.api.nvim_create_autocmd('DirChanged', {
  group = 'base',
  callback = function()
    local cwd = vim.fn.getcwd()
    local hostname = vim.fn.hostname()
    os.execute('printf "\\033]7;file://' .. hostname .. cwd .. '\\033\\\\"')
  end,
})

--
-- Custom Commands
--
vim.api.nvim_create_user_command('Scratch', function()
  vim.cmd('vnew')
  vim.cmd('e ~/vaults/scratch/index.md')
end, { desc = 'Scratch' })
vim.api.nvim_create_user_command('Journal', function()
  vim.cmd('e ' .. vim.fn.expand("%"):gsub("[^/]*$", "") .. vim.fn.strftime("%Y-%m-%d") .. '.md')
end, { desc = 'Journal' })

--
-- Keymaps
--
-- Single key mappings
vim.keymap.set("n", "<c-l>", "<cmd>nohlsearch<CR><C-L>")
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "_", "@:")
vim.keymap.set({"n", "x"}, "Y", '"+y')
vim.keymap.set("n", "<c-/>", "<cmd>FzfLgrepCurbuf<cr>")
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Single key mappings with leader
vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>q", function() require("quicker").toggle() end, { desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist" })
vim.keymap.set("n", "<leader>c", "<cmd>CopilotChatOpen<cr>", { desc = "Open Copilot Chat" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>s", "<cmd>Scratch<cr>", { desc = "Util scratch" })
vim.keymap.set("n", "<leader>j", "<cmd>Journal<cr>", { desc = "Util journal" })
vim.keymap.set('n', '<leader>g', '<cmd>vert G<cr>', { desc = 'Git status' })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, { desc = "LSP Diagnostics" })
vim.keymap.set("n", "<leader>m", "<cmd>TSC<cr>", { desc = "Compile TypeScript" })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set("n", "<leader>f", "<cmd>Flog<cr>", { desc = "Git log" })
vim.keymap.set("n", "<leader>o", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>:", function() require('telescope.builtin').commands() end, { desc = 'Telescope commands' })
vim.keymap.set("n", "<leader>?", function() require('telescope.builtin').keymaps({ default_text = "<Space>" }) end, { desc = "Telescope leader key mappings" })
vim.keymap.set("n", "<localleader>?", function() require('telescope.builtin').keymaps({ default_text = "\\" }) end, { desc = "Telescope localleader key mappings" })
vim.keymap.set('n', '<leader>b', '<cmd>GBrowse<cr>', { desc = 'Git browse' })
vim.keymap.set('n', '<leader>p', '<cmd>PBrowse<cr>', { desc = 'Git PR browse' })
vim.keymap.set('x', '<leader>b', ":GBrowse<cr>", { desc = 'Git browse' })
vim.keymap.set('x', '<leader>p', ":PBrowse<cr>", { desc = 'Git PR browse' })

-- TODO shortcuts
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- Tab navigation
vim.keymap.set("n", "<c-w><tab>", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<c-w><s-tab>", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<c-w>N", "<cmd>tabnew<cr>", { desc = "Open new tab" })

-- Fzf shortcuts
vim.keymap.set('n', '<c-p>', '<cmd>FzfFiles<cr>', { desc = 'FZF files' })
vim.keymap.set('n', 'gh', '<cmd>FzfMru<cr>', { desc = 'FZF MRU' })
vim.keymap.set('n', 'gs', '<cmd>FzfLiveGrepNative<cr>', { desc = 'FZF live grep' })
vim.keymap.set('n', 'gS', '<cmd>FzfGrepCword<cr>', { desc = 'FZF search word under cursor' })
vim.keymap.set('n', 'gd', '<cmd>FzfLspDefinitions<cr>', { desc = 'FZF LSP definitions' })
vim.keymap.set('n', 'gr', '<cmd>FzfLspReferences<cr>', { desc = 'FZF LSP references' })
vim.keymap.set('n', 'gy', '<cmd>FzfLspTypedefs<cr>', { desc = 'FZF LSP type definitions' })
vim.keymap.set('n', 'gl', '<cmd>FzfLspImplementations<cr>', { desc = 'FZF LSP implementations' })
vim.keymap.set('n', 'gz', '<cmd>FzfZoxide<cr>', { desc = 'FZF Zoxide' })

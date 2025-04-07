require("config.lazy")
require("config.cwd")
require("config.commands")
require("config.autocmds")

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
  virtual_lines = {
   current_line = true,
  },
})

--
-- Keymaps
--
-- Single key mappings
vim.keymap.set("n", "<c-l>", "<cmd>nohlsearch<CR><C-L>")
vim.keymap.set("n", "Q", "@q")
vim.keymap.set("n", "_", "@:")
vim.keymap.set({"n", "x"}, "Y", '"+y')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Single key mappings with leader
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Write | mnemonic - save" }) -- 連続して使用することはないので組み合わせで良い
vim.keymap.set("n", "<leader>q", function() require("quicker").toggle() end, { desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist" })
vim.keymap.set("n", "<leader>j", "<cmd>Journal<cr>", { desc = "Util journal" })
vim.keymap.set('n', '<leader>g', '<cmd>vert G<cr>', { desc = 'Git status' })
vim.keymap.set("n", "<leader>t", '<cmd>TodoQuickFix<cr>', { desc = "Set TODOs to qf" })
vim.keymap.set("n", "<leader>d", "<cmd>DailyScrum<cr>", { desc = "Util daily scrum - workday" })
vim.keymap.set("n", "<leader>D", "<cmd>DailyScrum!<cr>", { desc = "Util daily scrum - holiday" })
vim.keymap.set("n", "<leader>n", vim.diagnostic.setqflist, { desc = "Set LSP diagnostics to qf | mnemonic n of diagnostics" })
vim.keymap.set("n", "<leader>m", "<cmd>TSC<cr>", { desc = "Compile TypeScript" })
vim.keymap.set("n", "<leader>f", "<cmd>Flog<cr>", { desc = "Git log" })
vim.keymap.set("n", "<leader>o", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>:", function() require('telescope.builtin').commands() end, { desc = 'Telescope commands' })
vim.keymap.set("n", "<leader>?", function() require('telescope.builtin').keymaps({ default_text = "<Space>" }) end, { desc = "Telescope leader key mappings" })
vim.keymap.set("n", "<localleader>?", function() require('telescope.builtin').keymaps({ default_text = "\\" }) end, { desc = "Telescope localleader key mappings" })

-- Toggle options
vim.keymap.set("n", "yod", ':<C-R>=&diff ? "diffoff" : "diffthis"<CR><CR>', { desc = "Toggle diff" })
vim.keymap.set("n", "yow", ':set <C-R>=&wrap ? "nowrap" : "wrap"<CR><CR>', { desc = "Toggle wrap" })

-- TODO shortcuts
vim.keymap.set("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous todo comment" })

-- Extend window command
vim.keymap.set("n", "<c-w>N", "<cmd>tabnew<cr>", { desc = "Open new tab" })

-- Alternate navigation(overwrites print ascii value)
vim.keymap.set("n", "ga", "<cmd>A<cr>", { desc = "Alternate file" })

-- Fzf shortcuts
vim.keymap.set('n', '<c-p>', '<cmd>FzfFiles<cr>', { desc = 'FZF files' })
vim.keymap.set('n', 'gh', '<cmd>FzfMru<cr>', { desc = 'FZF MRU | mnemonic - history' })
vim.keymap.set('n', 'gl', '<cmd>FzfGrepProject<cr>', { desc = 'FZF grep project | mnemonic - go line' })
vim.keymap.set('n', 'g/', '<cmd>FzfGrepCurbuf<cr>', { desc = 'FZF grep current buffer | mnemonic - powerful /' })
vim.keymap.set('n', 'gz', '<cmd>FzfZoxide<cr>', { desc = 'FZF Zoxide' })

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP definition', buffer = event.buf })
    vim.keymap.set("n", "gK", vim.diagnostic.open_float, { desc = "Diagnostic float" })
  end,
})

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

vim.o.shortmess = vim.o.shortmess .. 'I'
vim.o.signcolumn = "yes"
vim.opt.diffopt:append('iwhite,algorithm:histogram,linematch:60,inline:word,vertical')

vim.o.undofile = true

-- Experimental: new messages/cmdline UI (Neovim 0.12+)
require('vim._core.ui2').enable({})

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
  jump = {
    float = true,
  },
})

--
-- Keymaps
--
-- Single key mappings
vim.keymap.set("n", "Q", "@q")
vim.keymap.set({"n", "x"}, "Y", '"+y')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "X", "@:", { desc = "Repeat last command" })

-- Single key mappings with leader
local function toggle_git_status()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].filetype == "fugitive" then
      vim.api.nvim_win_close(win, false)
      return
    end
  end

  vim.cmd("vert G")
end

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Write" })
vim.keymap.set("n", "<leader>s", function() require('fzf-lua').lsp_document_symbols() end, { desc = "FZF document symbols" })
vim.keymap.set("n", "<leader>q", function() require("quicker").toggle() end, { desc = "Toggle quickfix" })
vim.keymap.set("n", "<leader>l", function() require("quicker").toggle({ loclist = true }) end, { desc = "Toggle loclist" })
vim.keymap.set("n", "<leader>g", toggle_git_status, { desc = "Toggle git status" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.setqflist, { desc = "Set LSP diagnostics to qf" })
vim.keymap.set("n", "<leader>r", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>:", function() require('fzf-lua').commands() end, { desc = 'FZF commands' })
vim.keymap.set("n", "<leader>?", function() require('fzf-lua').keymaps({ query = "<Space>" }) end, { desc = "FZF leader key mappings" })
vim.keymap.set("n", "<localleader>?", function() require('fzf-lua').keymaps({ query = "\\" }) end, { desc = "FZF localleader key mappings" })

-- Toggle options
vim.keymap.set("n", "yod", function()
  if vim.o.diff then vim.cmd("diffoff") else vim.cmd("diffthis") end
end, { desc = "Toggle diff" })
vim.keymap.set("n", "yow", function()
  vim.o.wrap = not vim.o.wrap
end, { desc = "Toggle wrap" })

-- Tab navigation
vim.keymap.set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>", { desc = "Previous tab" })

-- Extend window command
vim.keymap.set("n", "<c-w>N", "<cmd>tabnew<cr>", { desc = "Open new tab" })

-- Fzf shortcuts
vim.keymap.set('n', '<leader>f', '<cmd>FzfFiles<cr>', { desc = 'FZF files' })
vim.keymap.set("n", "<leader>/", '<cmd>FzfGrepCurbuf<cr>', { desc = "FZF grep current buffer" })
vim.keymap.set("n", "<leader>h", '<cmd>FzfMru<cr>', { desc = "FZF MRU history" })
vim.keymap.set("n", "<leader>z", '<cmd>FzfZoxide<cr>', { desc = "FZF Zoxide" })

-- Terminal
vim.keymap.set('t', '<C-\\>', '<C-\\><C-n>')


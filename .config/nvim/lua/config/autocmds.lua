vim.api.nvim_create_augroup('base', {})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'base',
  callback = function()
    vim.highlight.on_yank({ higroup='Visual', timeout=500 })
  end
})

-- HACK: Fire projectionist apply template to files created via oil.nvim
vim.api.nvim_create_autocmd('BufRead', {
  group = 'base',
  pattern = {'*'},
  callback = function()
    local lines = vim.fn.getline(1, '$')
    if #lines == 1 and lines[1] == '' then
      vim.cmd('doautocmd BufNewFile')
    end
  end
})

local next = nil
local running = false

local function consume()
  -- lock execution
  if running then
    return
  end
  running = true

  -- consume state
  local current = next
  next = nil

  -- set variable
  local mode_str = current and 'true' or 'false'
  vim.system({
    "./karabiner_cli",
    "--set-variables",
    '{"insert_mode":' .. mode_str .. '}'
  }, {
    cwd = "/Library/Application Support/org.pqrs/Karabiner-Elements/bin"
  }, function()
    running = false
    if next ~= nil then
      consume()
    end
  end)
end

local function create_handler(mode)
  return function()
    next = mode
    consume()
  end
end

vim.api.nvim_create_autocmd({ 'InsertEnter', 'CmdlineEnter', 'TermEnter' }, {
  group = 'base',
  pattern = {'*'},
  callback = create_handler(true)
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'CmdlineLeave', 'TermLeave' }, {
  group = 'base',
  pattern = {'*'},
  callback = create_handler(false)
})

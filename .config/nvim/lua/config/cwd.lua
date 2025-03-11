-- https://github.com/wezterm/wezterm/discussions/3718
local function url_encode(str)
  return str:gsub("([^%w %-%_%.%~])",
    function(c) return string.format("%%%02X", string.byte(c)) end)
end

local function osc7_cwd()
  local hostname = vim.loop.os_uname().nodename
  local cwd = vim.fn.getcwd()
  local encoded_cwd = url_encode(cwd)
  local osc7_seq = string.format('\027]7;file://%s/%s\027\\', hostname, encoded_cwd)

  io.write(osc7_seq)
end

vim.api.nvim_create_augroup('OSC7', {})
vim.api.nvim_create_autocmd('DirChanged', {
  group = 'OSC7',
  callback = osc7_cwd,
})

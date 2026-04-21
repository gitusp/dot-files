local M = {}

-- Marker fold sits at this level; treesitter heading folds inside markers
-- are shifted by this amount so they nest deeper than the marker itself.
local MARKER_LEVEL = 11

local function marker_state(buf, lnum)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, lnum, false)
  local inside = false
  for i, line in ipairs(lines) do
    if line:match('^%s*<!%-%- fold %-%->%s*$') then
      if i == lnum then return 'start' end
      inside = true
    elseif line:match('^%s*<!%-%- /fold %-%->%s*$') then
      if i == lnum then return 'end' end
      inside = false
    end
  end
  return inside and 'inside' or nil
end

function M.foldtext()
  local start = vim.v.foldstart
  local line = vim.fn.getline(start)
  if not line:match('^%s*<!%-%- fold %-%->%s*$') then
    return vim.fn.foldtext()
  end
  local last = vim.fn.line('$')
  for lnum = start + 1, math.min(start + 10, last) do
    local l = vim.fn.getline(lnum)
    if l:match('%S') then
      line = l
      break
    end
  end
  local count = vim.v.foldend - vim.v.foldstart + 1
  return ('▸ %s  (%d lines)'):format(line:gsub('^%s+', ''), count)
end

function M.foldexpr()
  local state = marker_state(vim.api.nvim_get_current_buf(), vim.v.lnum)
  if state == 'start' then
    return '>' .. MARKER_LEVEL
  elseif state == 'end' then
    return '<' .. MARKER_LEVEL
  end
  local ts = vim.treesitter.foldexpr()
  if state == 'inside' then
    local prefix, num = ts:match('^([<>]?)(%d+)$')
    if num then
      return prefix .. (tonumber(num) + MARKER_LEVEL)
    end
  end
  return ts
end

return M

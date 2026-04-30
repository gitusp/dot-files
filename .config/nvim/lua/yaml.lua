local M = {}

function M.quote(s)
  return '"' .. s:gsub('\\', '\\\\'):gsub('"', '\\"') .. '"'
end

function M.unquote(s)
  local q = s:match('^"(.*)"$')
  if q then return q:gsub('\\"', '"'):gsub('\\\\', '\\') end
  return s
end

function M.parse_flow_seq(s, conv)
  local result = {}
  if not s then return result end
  local inner = s:match('^%[(.*)%]$')
  if not inner or vim.trim(inner) == '' then return result end
  for item in inner:gmatch('[^,]+') do
    local t = vim.trim(item)
    if t ~= '' then
      local v = conv(t)
      if v ~= nil then table.insert(result, v) end
    end
  end
  return result
end

function M.render_flow_seq(items, fmt)
  if #items == 0 then return '[]' end
  local parts = {}
  for _, v in ipairs(items) do
    table.insert(parts, fmt(v))
  end
  return '[' .. table.concat(parts, ', ') .. ']'
end

return M

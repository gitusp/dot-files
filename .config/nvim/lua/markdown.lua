local M = {}

function M.read_frontmatter(buf)
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  if lines[1] ~= '---' then return nil, 0 end
  local fm = {}
  for i = 2, #lines do
    if lines[i] == '---' then return fm, i end
    local k, v = lines[i]:match('^([%w_]+):%s*(.-)%s*$')
    if k then fm[k] = v end
  end
  return nil, 0
end

return M

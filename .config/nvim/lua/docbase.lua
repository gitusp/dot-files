local yaml = require('yaml')
local markdown = require('markdown')

local M = {}

local function merge_defaults(raw)
  raw = raw or {}
  return {
    title = raw.title and yaml.unquote(raw.title) or nil,
    id = raw.id and tonumber(raw.id:match('%d+')) or nil,
    domain = raw.domain,
    draft = raw.draft == 'true',
    notice = raw.notice == 'true',
    scope = (raw.scope and yaml.unquote(raw.scope)) or 'everyone',
    tags = raw.tags and yaml.parse_flow_seq(raw.tags, yaml.unquote) or {},
    groups = raw.groups and yaml.parse_flow_seq(raw.groups, tonumber) or {},
  }
end

local function render_frontmatter(fm)
  local lines = { '---', 'title: ' .. yaml.quote(fm.title) }
  if fm.id then table.insert(lines, 'id: ' .. tostring(fm.id)) end
  if fm.domain then table.insert(lines, 'domain: ' .. fm.domain) end
  table.insert(lines, 'draft: ' .. tostring(fm.draft))
  table.insert(lines, 'notice: ' .. tostring(fm.notice))
  table.insert(lines, 'scope: ' .. fm.scope)
  table.insert(lines, 'tags: ' .. yaml.render_flow_seq(fm.tags, yaml.quote))
  table.insert(lines, 'groups: ' .. yaml.render_flow_seq(fm.groups, tostring))
  table.insert(lines, '---')
  table.insert(lines, '')
  return lines
end

local function replace_frontmatter(buf, fm, fm_end)
  local rendered = render_frontmatter(fm)
  local replacement = fm_end > 0 and vim.list_slice(rendered, 1, #rendered - 1) or rendered
  vim.api.nvim_buf_set_lines(buf, 0, fm_end, false, replacement)
  vim.api.nvim_buf_call(buf, function()
    vim.cmd('silent noautocmd keepalt write')
  end)
end

function M.publish(buf)
  local token = vim.env.DOCBASE_TOKEN
  if not token or token == '' then
    vim.notify('docbase: DOCBASE_TOKEN must be set', vim.log.levels.ERROR)
    return
  end

  local raw, fm_end = markdown.read_frontmatter(buf)
  local fm = merge_defaults(raw)
  local body_lines = vim.api.nvim_buf_get_lines(buf, fm_end, -1, false)
  while body_lines[1] == '' do table.remove(body_lines, 1) end

  if not fm.title then
    local title = vim.fn.input('docbase title: ')
    if title == '' then
      vim.notify('docbase: aborted (empty title)', vim.log.levels.WARN)
      return
    end
    fm.title = title
  end

  local domain = fm.domain or vim.env.DOCBASE_DOMAIN
  if not domain or domain == '' then
    vim.notify('docbase: domain not set (frontmatter or $DOCBASE_DOMAIN)', vim.log.levels.ERROR)
    return
  end

  local payload = {
    title = fm.title,
    body = table.concat(body_lines, '\n'),
    draft = fm.draft,
    notice = fm.notice,
    scope = fm.scope,
    tags = fm.tags,
    groups = fm.groups,
  }

  local id = fm.id
  local method, url
  if id then
    method = 'PATCH'
    url = string.format('https://api.docbase.io/teams/%s/posts/%s', domain, id)
  else
    method = 'POST'
    url = string.format('https://api.docbase.io/teams/%s/posts', domain)
  end

  local cmd = {
    'curl', '-sS', '-X', method,
    '-H', 'X-DocBaseToken: ' .. token,
    '-H', 'Content-Type: application/json',
    '-d', vim.json.encode(payload),
    url,
  }

  local function handle(obj)
    if obj.code ~= 0 then
      vim.notify('docbase publish failed: ' .. (obj.stderr or ''), vim.log.levels.ERROR)
      return
    end
    local ok, data = pcall(vim.json.decode, obj.stdout or '')
    if not ok or type(data) ~= 'table' then
      vim.notify('docbase: invalid response', vim.log.levels.ERROR)
      return
    end
    if data.error then
      local msg = data.error
      if data.messages then msg = msg .. ': ' .. table.concat(data.messages, ', ') end
      vim.notify('docbase: ' .. msg, vim.log.levels.ERROR)
      return
    end
    if not vim.api.nvim_buf_is_valid(buf) then return end
    if not id and data.id then
      fm.id = data.id
      replace_frontmatter(buf, fm, fm_end)
    end
  end

  if id then
    vim.system(cmd, { text = true }, function(obj)
      vim.schedule(function() handle(obj) end)
    end)
  else
    handle(vim.system(cmd, { text = true }):wait())
  end
end

function M.setup()
  vim.api.nvim_create_augroup('docbase-publish', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = 'docbase-publish',
    pattern = '*.docbase.md',
    callback = function(args) M.publish(args.buf) end,
  })
end

return M

local M = {}

local filetypes = { "markdown", "docbase" }

local function parse_line(line)
  local indent = line:match("^(%s*)- %[[ xX]%] .*")
  if indent then
    return { type = "checkbox", indent = indent }
  end

  indent = line:match("^(%s*)- .*")
  if indent then
    return { type = "list", indent = indent }
  end

  local num
  indent, num = line:match("^(%s*)(%d+)%. .*")
  if indent then
    return { type = "numbered", indent = indent, number = tonumber(num) }
  end

  return {}
end

local function build_prefix(info, number_delta)
  if info.type == "checkbox" then
    return info.indent .. "- [ ] "
  elseif info.type == "list" then
    return info.indent .. "- "
  elseif info.type == "numbered" then
    return info.indent .. math.max(info.number + number_delta, 1) .. ". "
  end
end

-- i <CR>: リスト行ならカーソル位置で行を分割し、次の行にリスト prefix を継続
--   - [ ] foo → - [ ] foo / - [ ]
--   - foo     → - foo / -
--   1. foo    → 1. foo / 2.
function M.cr()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local prefix = build_prefix(parse_line(line), 1)

  if not prefix then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
    return
  end

  local before = line:sub(1, col)
  local after = line:sub(col + 1)
  vim.api.nvim_set_current_line(before)
  vim.api.nvim_buf_set_lines(0, row, row, false, { prefix .. after })
  vim.api.nvim_win_set_cursor(0, { row + 1, #prefix })
end

-- i [: `- ` の直後（内容なし）で `[ ] ` を挿入 → `- [ ] ` になる
function M.open_bracket()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before = line:sub(1, col)
  if before:match("^%s*- $") and line:sub(col + 1) == "" then
    return "[ ] "
  end
  return "["
end

-- i <BS>: `- [ ] ` の直後で `[ ] ` (4文字) を削除 → `- ` に戻る
function M.bs()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local line = vim.api.nvim_get_current_line()
  local before = line:sub(1, col)
  if before:match("^%s*- %[ %] $") and line:sub(col + 1) == "" then
    vim.api.nvim_set_current_line(before:sub(1, -5) .. line:sub(col + 1))
    vim.api.nvim_win_set_cursor(0, { row, col - 4 })
    return
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS>", true, false, true), "n", false)
end

-- n/v <CR>: チェックボックスをトグル ([ ] ↔ [x])
-- 範囲内の最初のチェックボックスの状態で方向を統一
function M.toggle_checkbox(line1, line2)
  local dest
  for lnum = line1, line2 do
    local pre, state, post = vim.fn.getline(lnum):match("^(%s*- %[)([ xX])(%].*)$")
    if pre then
      dest = dest or ((state == " ") and "x" or " ")
      vim.fn.setline(lnum, pre .. dest .. post)
    end
  end
end

-- n o/O: リスト行なら prefix 付きの新しい行を挿入して insert mode に入る
--   o: 下に追加 (numbered は N+1)
--   O: 上に追加 (numbered は max(N-1, 1))
local function open_line(direction)
  local count = vim.v.count1
  local line = vim.api.nvim_get_current_line()
  local info = parse_line(line)
  local row = vim.api.nvim_win_get_cursor(0)[1]
  local number_delta = (direction == "below") and 1 or -1
  local prefix = build_prefix(info, number_delta)

  if not prefix then
    vim.cmd("normal! " .. count .. ((direction == "below") and "o" or "O"))
    return
  end

  local lines = {}
  for i = 1, count do
    if info.type == "numbered" then
      lines[i] = build_prefix(info, number_delta * i)
    else
      lines[i] = prefix
    end
  end

  local insert_row = (direction == "below") and row or (row - 1)
  local last_prefix = lines[count]
  vim.api.nvim_buf_set_lines(0, insert_row, insert_row, false, lines)
  local cursor_row = (direction == "below") and (row + count) or row
  vim.api.nvim_win_set_cursor(0, { cursor_row, #last_prefix })
  vim.cmd("startinsert!")
end

function M.o() open_line("below") end
function M.O() open_line("above") end

local function setup_buffer()
  local opts = { buffer = true, silent = true }

  vim.keymap.set("i", "<CR>", M.cr, opts)
  vim.keymap.set("i", "[", M.open_bracket, { buffer = true, silent = true, expr = true })
  vim.keymap.set("i", "<BS>", M.bs, opts)
  vim.keymap.set("n", "<CR>", function()
    M.toggle_checkbox(vim.fn.line("."), vim.fn.line("."))
  end, opts)
  vim.keymap.set("v", "<CR>", function()
    -- `:<C-u>` 相当: normal モードに戻し '< '> マークを確定させる
    vim.cmd("normal! \27")
    M.toggle_checkbox(vim.fn.line("'<"), vim.fn.line("'>"))
  end, opts)
  vim.keymap.set("n", "o", M.o, opts)
  vim.keymap.set("n", "O", M.O, opts)
end

return {
  {
    dir = "markdown-list",
    virtual = true,
    ft = filetypes,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = filetypes,
        callback = function(args)
          if vim.bo[args.buf].filetype == "docbase" then
            local first_line = vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] or ""
            if first_line:match("^metarw") then return end
          end
          setup_buffer()
        end,
      })
    end,
  },
}

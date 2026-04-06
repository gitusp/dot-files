-- Fuzzy command fallback: when an unknown Ex command is executed,
-- resolve it via case-sensitive subsequence matching against all
-- available commands. If exactly one match is found, execute that
-- instead. e.g. :GG → :GitGraph, :DS → :DailyScrum
return {
  {
    dir = "fuzzy-command",
    virtual = true,
    event = "CmdlineEnter",
    config = function()
      local function subsequence(input, candidate)
        local i = 1
        for j = 1, #candidate do
          if candidate:sub(j, j) == input:sub(i, i) then
            i = i + 1
            if i > #input then return true end
          end
        end
        return false
      end

      local cr = vim.api.nvim_replace_termcodes('<CR>', true, false, true)
      local c_u = vim.api.nvim_replace_termcodes('<C-u>', true, false, true)

      vim.keymap.set('c', '<CR>', function()
        if vim.fn.getcmdtype() ~= ':' then return cr end
        local line = vim.fn.getcmdline()
        local cmd, rest = line:match('^(%S+)(.*)')
        if not cmd or vim.fn.exists(':' .. cmd) > 0 then return cr end

        local matches = vim.tbl_filter(
          function(c) return subsequence(cmd, c) end,
          vim.fn.getcompletion('', 'command')
        )
        if #matches == 1 then
          return c_u .. matches[1] .. rest .. cr
        end
        return cr
      end, { expr = true })
    end,
  },
}

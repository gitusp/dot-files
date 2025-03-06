return {
  {
    "jake-stewart/multicursor.nvim",
    branch = "1.0",
    config = function()
      local mc = require("multicursor-nvim")

      mc.setup()

      local set = vim.keymap.set

      -- Add or skip adding a new cursor by matching word/selection
      set({"n", "x"}, "<c-n>", function() mc.matchAddCursor(1) end)
      set({"n", "x"}, "<c-s>", function() mc.matchSkipCursor(1) end)

      -- Rotate the main cursor.
      set({"n", "x"}, "]r", mc.nextCursor)
      set({"n", "x"}, "[r", mc.prevCursor)

      set("n", "<esc>", function()
        if not mc.cursorsEnabled() then
          mc.enableCursors()
        elseif mc.hasCursors() then
          mc.clearCursors()
        else
          -- Default <esc> handler.
        end
      end)

      -- Append/insert for each line of visual selections.
      set("x", "I", mc.insertVisual)
      set("x", "A", mc.appendVisual)

      -- Jumplist support
      set({"x", "n"}, "<c-i>", mc.jumpForward)
      set({"x", "n"}, "<c-o>", mc.jumpBackward)

      -- Customize how cursors look.
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn"})
      hl(0, "MultiCursorMatchPreview", { link = "Search" })
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    end
  }
}

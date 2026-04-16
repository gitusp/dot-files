return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  opts = {
    multiplexer_integration = "wezterm",
  },
  config = function(_, opts)
    local ss = require("smart-splits")
    ss.setup(opts)

    vim.keymap.set("n", "<C-w>h", ss.move_cursor_left, { desc = "Move to left split/pane" })
    vim.keymap.set("n", "<C-w>j", ss.move_cursor_down, { desc = "Move to below split/pane" })
    vim.keymap.set("n", "<C-w>k", ss.move_cursor_up, { desc = "Move to above split/pane" })
    vim.keymap.set("n", "<C-w>l", ss.move_cursor_right, { desc = "Move to right split/pane" })
    vim.keymap.set("n", "<C-w><C-h>", ss.move_cursor_left, { desc = "Move to left split/pane" })
    vim.keymap.set("n", "<C-w><C-j>", ss.move_cursor_down, { desc = "Move to below split/pane" })
    vim.keymap.set("n", "<C-w><C-k>", ss.move_cursor_up, { desc = "Move to above split/pane" })
    vim.keymap.set("n", "<C-w><C-l>", ss.move_cursor_right, { desc = "Move to right split/pane" })

    local function resize_mode()
      vim.api.nvim_echo({ { "-- RESIZE --", "ModeMsg" } }, false, {})
      while true do
        local ok, key = pcall(vim.fn.getcharstr)
        if not ok then break end
        local actions = {
          h = function() ss.resize_left(1) end,
          j = function() ss.resize_down(1) end,
          k = function() ss.resize_up(1) end,
          l = function() ss.resize_right(1) end,
          H = function() ss.resize_left(10) end,
          J = function() ss.resize_down(10) end,
          K = function() ss.resize_up(10) end,
          L = function() ss.resize_right(10) end,
        }
        local action = actions[key]
        if action then
          action()
        else
          vim.api.nvim_feedkeys(key, "m", true)
          break
        end
        vim.cmd("redraw")
      end
      vim.api.nvim_echo({ { "", "" } }, false, {})
    end

    vim.keymap.set("n", "<C-w>r", resize_mode, { desc = "Resize mode" })
    vim.keymap.set("n", "<C-w><C-r>", resize_mode, { desc = "Resize mode" })

    local function wezterm_cli(args)
      vim.fn.system("wezterm cli " .. args)
    end
    vim.keymap.set("n", "<C-w>%", function() wezterm_cli("split-pane --right") end, { desc = "WezTerm split right" })
    vim.keymap.set("n", '<C-w>"', function() wezterm_cli("split-pane --bottom") end, { desc = "WezTerm split bottom" })
    vim.keymap.set("n", "<C-w>z", function() wezterm_cli("zoom-pane --toggle") end, { desc = "WezTerm toggle zoom" })
    vim.keymap.set("n", "<C-w><c-z>", function() wezterm_cli("zoom-pane --toggle") end, { desc = "WezTerm toggle zoom" })
    vim.keymap.set("n", "<C-w>[", function()
      io.write("\x1b]1337;SetUserVar=WEZTERM_COPY_MODE=MQ==\x07")
      io.flush()
    end, { desc = "WezTerm copy mode" })
    vim.keymap.set("n", "<C-w>!", function()
      wezterm_cli("move-pane-to-new-tab")
      wezterm_cli("activate-tab --tab-index -1")
    end, { desc = "WezTerm pane to tab" })
  end,
}

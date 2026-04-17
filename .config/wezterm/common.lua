local wezterm = require 'wezterm'
local act = wezterm.action

local M = {}

function M.decorate(config)
  config.window_decorations = 'RESIZE'
  config.hide_tab_bar_if_only_one_tab = true
  config.font = wezterm.font('PlemolJP Console NF', { weight = 'Medium' })
  config.font_size = 12.0
  config.line_height = 1.1
  config.cell_width = 1.05
  config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

  local function is_nvim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
  end

  config.keys = {
    {
      key = "w",
      mods = "CTRL",
      action = wezterm.action_callback(function(window, pane)
        if is_nvim(pane) then
          window:perform_action(act.SendKey({ key = "w", mods = "CTRL" }), pane)
        else
          window:perform_action(act.ActivateKeyTable({ name = "ctrl_w", one_shot = true, timeout_milliseconds = 1000 }), pane)
        end
      end),
    },
    { key = "q", mods = "CTRL", action = act.SendKey({ key = "q", mods = "CTRL" }) },
    { key = "w", mods = "SUPER", action = act.CloseCurrentPane({ confirm = true }) },
  }

  config.key_tables = {
    ctrl_w = {
      { key = "%", mods = "SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
      { key = '"', mods = "SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

      { key = "w", mods = "CTRL", action = act.SendKey({ key = "w", mods = "CTRL" }) },

      { key = "h", action = act.ActivatePaneDirection("Left") },
      { key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
      { key = "j", action = act.ActivatePaneDirection("Down") },
      { key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
      { key = "k", action = act.ActivatePaneDirection("Up") },
      { key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
      { key = "l", action = act.ActivatePaneDirection("Right") },
      { key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },

      { key = "Space", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false, until_unknown = true }) },
      { key = "Space", mods = "CTRL", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false, until_unknown = true }) },

      { key = "z", action = act.TogglePaneZoomState },
      { key = "z", mods = "CTRL", action = act.TogglePaneZoomState },

      { key = "[", action = act.ActivateCopyMode },
      { key = "[", mods = "CTRL", action = act.ActivateCopyMode },

      { key = "!", mods = "SHIFT", action = wezterm.action_callback(function(_, pane)
        local tab, _ = pane:move_to_new_tab()
        tab:activate()
      end) },
    },
    resize_pane = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "H", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 10 }) },
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "J", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 10 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "K", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 10 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "L", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 10 }) },
    },
  }
  wezterm.on("user-var-changed", function(window, pane, name, _value)
    if name == "WEZTERM_COPY_MODE" then
      window:perform_action(act.ActivateCopyMode, pane)
    end
  end)
end

return M

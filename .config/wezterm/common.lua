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

  config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }

  config.keys = {
    { key = "%", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = '"', mods = "LEADER|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
    { key = "h", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Left") },
    { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    { key = "j", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Down") },
    { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
    { key = "k", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Up") },
    { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
    { key = "l", mods = "LEADER|CTRL", action = act.ActivatePaneDirection("Right") },

    { key = "H", mods = "LEADER|SHIFT", action = act.Multiple({
      act.AdjustPaneSize({ "Left", 10 }),
      act.ActivateKeyTable({ name = "resize_horizontal", one_shot = false, until_unknown = true }),
    })},
    { key = "J", mods = "LEADER|SHIFT", action = act.Multiple({
      act.AdjustPaneSize({ "Down", 10 }),
      act.ActivateKeyTable({ name = "resize_vertical", one_shot = false, until_unknown = true }),
    })},
    { key = "K", mods = "LEADER|SHIFT", action = act.Multiple({
      act.AdjustPaneSize({ "Up", 10 }),
      act.ActivateKeyTable({ name = "resize_vertical", one_shot = false, until_unknown = true }),
    })},
    { key = "L", mods = "LEADER|SHIFT", action = act.Multiple({
      act.AdjustPaneSize({ "Right", 10 }),
      act.ActivateKeyTable({ name = "resize_horizontal", one_shot = false, until_unknown = true }),
    })},

    { key = "z", mods = "LEADER", action = act.TogglePaneZoomState },
    { key = "z", mods = "LEADER|CTRL", action = act.TogglePaneZoomState },

    { key = "[", mods = "LEADER", action = act.ActivateCopyMode },
    { key = "[", mods = "LEADER|CTRL", action = act.ActivateCopyMode },
  }

  config.key_tables = {
    resize_horizontal = {
      { key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
      { key = "H", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 10 }) },
      { key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
      { key = "L", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 10 }) },
    },
    resize_vertical = {
      { key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
      { key = "J", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 10 }) },
      { key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
      { key = "K", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 10 }) },
    },
  }
end

return M

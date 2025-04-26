local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Tomorrow'
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font('PlemolJP Console NF', { weight = 'Medium' })
config.font_size = 12.0
config.line_height = 1.1
config.cell_width = 1.05
config.initial_rows = 96
config.initial_cols = 320
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

config.keys = {
  {
    key = 'q',
    mods = 'CTRL',
    action = wezterm.action.SendString '\x11',
  },
}

config.colors = {
  cursor_fg = "#000000",
  cursor_bg = "#cccccc",
  compose_cursor = 'white'
}

return config

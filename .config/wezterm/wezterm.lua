local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.color_scheme = 'Tomorrow'
config.window_decorations = 'RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font('Source Han Code JP', { weight = 'Medium' })
config.font_size = 11.0

return config

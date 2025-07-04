local wezterm = require 'wezterm'
local common = require 'common'

local config = wezterm.config_builder()

common.decorate(config)

config.initial_rows = 96
config.initial_cols = 320

return config

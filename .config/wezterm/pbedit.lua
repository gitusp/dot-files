local wezterm = require 'wezterm'
local common = require 'common'

local config = wezterm.config_builder()

common.decorate(config)

return config

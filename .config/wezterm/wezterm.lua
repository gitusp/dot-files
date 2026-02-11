local wezterm = require 'wezterm'
local common = require 'common'

local config = wezterm.config_builder()

common.decorate(config)

local executable_path = wezterm.executable_dir or ""

if executable_path:find("WezNote.app") then
  config.color_scheme = 'Tomorrow Night'
  config.initial_rows = 36
  config.initial_cols = 120
  config.set_environment_variables = {
    WEZNOTE_INSTANCE = '1',
  }
  config.default_prog = { '/bin/zsh', '-lc', "nvim -c 'DailyScrum'" }
else
  config.color_scheme = 'Tomorrow'
  config.initial_rows = 96
  config.initial_cols = 320
end

return config

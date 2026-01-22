local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font_size = 10
config.font = wezterm.font 'JetBrains Mono'
config.default_cursor_style = "BlinkingBar"
config.color_scheme = 'Tokyo Night'
config.initial_cols = 120
config.initial_rows = 30
config.hide_tab_bar_if_only_one_tab = true
config.enable_tab_bar = true

config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

config.keys = {
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.SplitHorizontal{ domain = 'CurrentPaneDomain' } },
  { key = 'DownArrow', mods = 'CTRL', action = wezterm.action.SplitVertical{ domain = 'CurrentPaneDomain' } },
  
  { key = 'LeftArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection('Left') },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection('Right') },
  { key = 'UpArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection('Up') },
  { key = 'DownArrow', mods = 'ALT', action = wezterm.action.ActivatePaneDirection('Down') },
  
  { key = 't', mods = 'CTRL|SHIFT', action = wezterm.action.SpawnTab('CurrentPaneDomain') },
  { key = 'w', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentPane{ confirm = true } },
	{ key = 'q', mods = 'CTRL|SHIFT', action = wezterm.action.CloseCurrentTab{ confirm = true } },

	{ key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
	{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
	{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
}

return config

local wezterm = require 'wezterm'
local act = wezterm.action

return {
  font_size = 10,
  font = wezterm.font 'JetBrains Mono',
  default_cursor_style = "BlinkingBar",
  color_scheme = 'Tokyo Night',
  initial_cols = 100,
  initial_rows = 30,
  hide_tab_bar_if_only_one_tab = true,
  enable_tab_bar = true,
  
	window_background_opacity = 0.90,

	window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10
  },
  
	mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Right" } },
      action = wezterm.action.PasteFrom("Clipboard"),
    },
  },

  keys = {
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
}

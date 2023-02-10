local wezterm = require 'wezterm'

return {
  font = wezterm.font 'JetBrainsMono Nerd Font',
  -- font = wezterm.font 'Hack Nerd Font',
  -- font = wezterm.font 'JuliaMono',
  font_size = 13,
  -- Disable ligatures
  harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'},
  -- line_height = 1.1,
  color_scheme = "Catppuccin Mocha",
  -- color_scheme = "MaterialDarker",
  -- color_scheme = "MaterialOcean",
  -- color_scheme = "Monokai Remastered",
  hide_tab_bar_if_only_one_tab = true,
  window_frame = {
    border_left_width = 0,
    border_right_width = 0,
    border_bottom_height = 0,
    border_top_height = 0
  },
  window_decorations = "TITLE | RESIZE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  },
  keys = {
    {mods = "ALT", key = "Enter", action = wezterm.action.DisableDefaultAssignment}
  }
}

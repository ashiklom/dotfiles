local wezterm = require 'wezterm'

local act = wezterm.action

local tabkeys = {}
for i = 1, 9 do
  table.insert(tabkeys, {key = tostring(i), mods = "LEADER", action = act.ActivateTab(i-1)})
end

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
  leader = {mods = "CTRL", key = "a", timeout_milliseconds = 10000},
  keys = {
    {mods = "LEADER", key = "-", action = act.SplitPane{direction = "Down"}},
    {mods = "LEADER", key = "_", action = act.SplitPane{direction = "Up"}},
    {mods = "LEADER", key = "\\", action = act.SplitPane{direction = "Right"}},
    {mods = "LEADER", key = "|", action = act.SplitPane{direction = "Left"}},
    {mods = "LEADER", key = "j", action = act.ActivatePaneDirection 'Down'},
    {mods = "LEADER", key = "k", action = act.ActivatePaneDirection 'Up'},
    {mods = "LEADER", key = "h", action = act.ActivatePaneDirection 'Left'},
    {mods = "LEADER", key = "l", action = act.ActivatePaneDirection 'Right'},
    {mods = "LEADER|SHIFT", key = "J", action = act.AdjustPaneSize {'Down', 5}},
    {mods = "LEADER|SHIFT", key = "K", action = act.AdjustPaneSize {'Up', 5}},
    {mods = "LEADER|SHIFT", key = "H", action = act.AdjustPaneSize {'Left', 5}},
    {mods = "LEADER|SHIFT", key = "L", action = act.AdjustPaneSize {'Right', 5}},
    {mods = "LEADER", key = ">", action = act.RotatePanes 'Clockwise'},
    {mods = "LEADER", key = "<", action = act.RotatePanes 'CounterClockwise'},
    {mods = "LEADER", key = "w", action = act.PaneSelect {mode = "Activate"}},
    {mods = "LEADER", key = "s", action = act.PaneSelect {mode = "SwapWithActive"}},
    {mods = "LEADER", key = "Enter", action = act.ActivateCopyMode},
    {mods = "LEADER", key = "?", action = act.QuickSelect},
    {mods = "LEADER", key = "n", action = act.SpawnTab "CurrentPaneDomain"},
    {mods = "LEADER", key = "z", action = act.TogglePaneZoomState},
    {mods = "LEADER", key = "p", action = act.PasteFrom "Clipboard"},
    -- {mods = "LEADER", key = ":", action = act.ActivateCommandPalette},
    {mods = "ALT", key = "Enter", action = act.DisableDefaultAssignment},
    table.unpack(tabkeys)
  }
}

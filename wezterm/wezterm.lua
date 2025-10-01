local wezterm = require 'wezterm'
local config = {}

local act = wezterm.action

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrains Mono')
config.font_size = 13.0
-- Disable ligatures
config.harfbuzz_features = { 'calt = 0', 'clig = 0', 'liga = 0' }

-- No easing of cursor blink
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.cursor_blink_rate = 600

config.adjust_window_size_when_changing_font_size = false

config.keys = {
  {
    key = "d",
    mods = "SUPER",
    action = act.SplitHorizontal {domain = "CurrentPaneDomain" }
  },
  {
    key = "d",
    mods = "SUPER|SHIFT",
    action = act.SplitVertical {domain = "CurrentPaneDomain"}
  },
  {
    key = "p",
    mods = "SUPER|SHIFT",
    action = act.ActivateCommandPalette
  },
  {
    key = "x",
    mods = "SUPER|SHIFT",
    action = act.ActivateCopyMode
  },
  {
    key = ".",
    mods = "SUPER|SHIFT",
    action = act.ActivateWindowRelative(1)
  },
  {
    key = ",",
    mods = "SUPER|SHIFT",
    action = act.ActivateWindowRelative(-1)
  }
}

local dir_keys = {
  {"RightArrow", "Right"},
  {"LeftArrow", "Left"},
  {"UpArrow", "Up"},
  {"DownArrow", "Down"},
  {"h", "Left"},
  {"l", "Right"},
  {"k", "Up"},
  {"j", "Down"},
}

for _, pair in ipairs(dir_keys) do
  local key = pair[1]
  local dir = pair[2]
  table.insert(config.keys, {
    key = key,
    mods = "SUPER",
    action = act.ActivatePaneDirection(dir)
  })
end

local io = require 'io'
local os = require 'os'

wezterm.on('trigger-vim-with-scrollback', function(window, pane)
  -- Retrieve the text from the pane
  local text = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows)

  -- Create a temporary file to pass to vim
  local name = os.tmpname()
  local f = io.open(name, 'w+')
  f:write(text)
  f:flush()
  f:close()

  -- Open a new window running vim and tell it to open the file
  window:perform_action(
    act.SpawnCommandInNewWindow {
      args = { '/opt/homebrew/bin/nvim', name },
    },
    pane
  )

  -- Wait "enough" time for vim to read the file before we remove it.
  -- The window creation and process spawn are asynchronous wrt. running
  -- this script and are not awaitable, so we just pick a number.
  --
  -- Note: We don't strictly need to remove this file, but it is nice
  -- to avoid cluttering up the temporary directory.
  wezterm.sleep_ms(1000)
  os.remove(name)
end)

table.insert(config.keys, {
  key = 'E',
  mods = 'CMD|SHIFT',
  action = act.EmitEvent 'trigger-vim-with-scrollback',
})

-- config.key_tables = {
--   search_mode = {
--     {
--       key = 'Enter',
--       mods = 'NONE',
--       action = act.Multiple({
--         act.CopyMode("AcceptPattern"),
--         act.PopKeyTable
--         -- act.CopyMode({ SetSelectionMode = 'Cell' })
--       })
--     },
--     {
--       key = 'Escape',
--       mods = 'NONE',
--       action = act.Multiple({
--         act.CopyMode("ClearPattern"),
--         act.CopyMode("AcceptPattern"),
--         act.PopKeyTable
--       }),
--     }
--   },
-- }

return config

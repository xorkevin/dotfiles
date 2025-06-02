local wezterm = require('wezterm')

local config = wezterm.config_builder()

config.default_prog = { '/usr/bin/zsh' }

config.font = wezterm.font('Hack Nerd Font Mono')
config.font_size = 9
config.cell_width = 1.1

config.color_scheme = 'tokyonight_night'

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true

config.window_padding = { left = 2, right = 2, top = 2, bottom = 2 }

config.disable_default_key_bindings = true
config.leader = {
  key = 'Space',
  mods = 'CTRL',
  timeout_milliseconds = 1000,
}
config.keys = {
  -- leader
  {
    key = 'Space',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendKey({ key = 'Space', mods = 'CTRL' }),
  },
  -- commands
  {
    key = ':',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.ActivateCommandPalette,
  },
  -- copy mode
  {
    key = 'y',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = 'y',
    mods = 'LEADER',
    action = wezterm.action.ActivateCopyMode,
  },
  {
    key = 'V',
    mods = 'CTRL',
    action = wezterm.action.PasteFrom('Clipboard'),
  },
  -- windows and tabs
  {
    key = 'C',
    mods = 'LEADER',
    action = wezterm.action.SpawnWindow,
  },
  {
    key = 'c',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SpawnTab('DefaultDomain'),
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab('DefaultDomain'),
  },
  {
    key = 'n',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'p',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = 'N',
    mods = 'LEADER',
    action = wezterm.action.MoveTabRelative(1),
  },
  {
    key = 'P',
    mods = 'LEADER',
    action = wezterm.action.MoveTabRelative(-1),
  },
  {
    key = 'x',
    mods = 'LEADER|CTRL',
    action = wezterm.action.CloseCurrentPane({ confirm = true }),
  },
  -- panes
  {
    key = 'u',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SplitHorizontal({ domain = 'DefaultDomain' }),
  },
  {
    key = 'u',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal({ domain = 'DefaultDomain' }),
  },
  {
    key = 'i',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SplitVertical({ domain = 'DefaultDomain' }),
  },
  {
    key = 'i',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical({ domain = 'DefaultDomain' }),
  },
  {
    key = 'h',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivatePaneDirection('Left'),
  },
  {
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection('Left'),
  },
  {
    key = 'j',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivatePaneDirection('Down'),
  },
  {
    key = 'j',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection('Down'),
  },
  {
    key = 'k',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivatePaneDirection('Up'),
  },
  {
    key = 'k',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection('Up'),
  },
  {
    key = 'l',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivatePaneDirection('Right'),
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection('Right'),
  },
  {
    key = 'm',
    mods = 'LEADER|CTRL',
    action = wezterm.action.PaneSelect({ mode = 'Activate' }),
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = wezterm.action.PaneSelect({ mode = 'Activate' }),
  },
  {
    key = 'M',
    mods = 'LEADER',
    action = wezterm.action.PaneSelect({ mode = 'SwapWithActiveKeepFocus' }),
  },
  {
    key = 'r',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ActivateKeyTable({
      name = 'resize_pane',
      one_shot = false,
    }),
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable({
      name = 'resize_pane',
      one_shot = false,
    }),
  },
  -- font size
  {
    key = '=',
    mods = 'LEADER|CTRL',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '=',
    mods = 'LEADER',
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = '-',
    mods = 'LEADER|CTRL',
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = '0',
    mods = 'LEADER|CTRL',
    action = wezterm.action.ResetFontSize,
  },
  {
    key = '0',
    mods = 'LEADER',
    action = wezterm.action.ResetFontSize,
  },
}

local copy_mode_key_table = wezterm.gui.default_key_tables().copy_mode
table.insert(copy_mode_key_table, {
  key = 'y',
  mods = 'NONE',
  action = wezterm.action.CopyTo('ClipboardAndPrimarySelection'),
})

config.key_tables = {
  copy_mode = copy_mode_key_table,
  resize_pane = {
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'q',      action = 'PopKeyTable' },
    { key = 'h',      action = wezterm.action.AdjustPaneSize({ 'Left', 1 }) },
    { key = 'l',      action = wezterm.action.AdjustPaneSize({ 'Right', 1 }) },
    { key = 'k',      action = wezterm.action.AdjustPaneSize({ 'Up', 1 }) },
    { key = 'j',      action = wezterm.action.AdjustPaneSize({ 'Down', 1 }) },
  },
}

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'keytable:' .. name
  end
  window:set_right_status(name or '')
end)

return config

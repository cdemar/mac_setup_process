local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font and UI setup
config.font = wezterm.font("MesloLGS Nerd Font Mono")
config.font_size = 18
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

-- Make window take full screen space on launch
config.window_padding = {
  left = '.5cell',
  right = '.5cell',
  top = '0.25cell',
  bottom = '0.25cell',
}

-- Make the window large on launch
config.initial_cols = 200
config.initial_rows = 60

-- Coolnight colorscheme
config.colors = {
	foreground = "#CBE0F0",
	background = "#011423",
	cursor_bg = "#47FF9C",
	cursor_border = "#47FF9C",
	cursor_fg = "#011423",
	selection_bg = "#033259",
	selection_fg = "#CBE0F0",
	ansi = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#0FC5ED", "#a277ff", "#24EAF7", "#24EAF7" },
	brights = { "#214969", "#E52E2E", "#44FFB1", "#FFE073", "#A277FF", "#a277ff", "#24EAF7", "#24EAF7" },
}

-- Custom keybindings
config.keys = {
  -- Horizontal split: Cmd + |
  {
    key = "|",
    mods = "CMD",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },

  -- Vertical split: Cmd + _
  {
    key = "_",
    mods = "CMD",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },

  -- Pane navigation
  { key = "h", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Left") },
  { key = "l", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "k", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Up") },
  { key = "j", mods = "CMD", action = wezterm.action.ActivatePaneDirection("Down") },

  -- New tab: Cmd + t
  {
    key = "t",
    mods = "CMD",
    action = wezterm.action.SpawnTab("CurrentPaneDomain"),
  },

  -- Close pane or tab: Cmd + w
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
}

return config


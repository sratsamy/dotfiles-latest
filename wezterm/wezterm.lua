local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- kun chen config
config.font = wezterm.font("MesloLGS Nerd Font Mono")
-- config.font = wezterm.font("JetBrainsMono Nerd Font")
-- config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15
--config.window_background_opacity = 0.8
--config.macos_window_background_blur = 50 
config.hide_tab_bar_if_only_one_tab = true
-- config.enable_tab_bar = true 
config.window_decorations = "RESIZE"

config.keys = {
  { key = "d", mods = "CMD", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "d", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
}

-- config.color_scheme = "rose-pine-moon"
-- joseon colors
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

return config

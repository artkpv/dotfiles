local wezterm = require("wezterm")
local config = {}

config.color_scheme = "GruvboxDark"
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 10.0
config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}
config.window_close_confirmation = "NeverPrompt"
return config

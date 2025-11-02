local wezterm = require("wezterm")

return {
	enable_wayland = false,

	font = wezterm.font_with_fallback({
		"Cascadia Code NF Light",
		"JetBrainsMono Nerd Font",
		"Symbols Nerd Font",
		"Noto Color Emoji",
		"Noto Sans CJK JP",
		"Noto Sans",
		"DejaVu Sans Mono",
	}),

	keys = {
		{
			key = "F11", -- or any key you like
			mods = "NONE",
			action = wezterm.action.ToggleFullScreen,
		},
	},

	font_size = 12.0,
	window_background_opacity = 0.75,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
}

local wezterm = require("wezterm")

return {
	enable_wayland = false,

	font = wezterm.font_with_fallback({
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

	default_prog = { "/usr/bin/fish", "-l" },
	font_size = 11.0,
	window_background_opacity = 0.40,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
}

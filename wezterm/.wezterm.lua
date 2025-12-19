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
			key = "F11",
			mods = "NONE",
			action = wezterm.action.ToggleFullScreen,
		},
	},

	default_prog = { "/usr/bin/fish", "-l" },
	font_size = 11.0,
	enable_tab_bar = false,
	window_decorations = "RESIZE",

	-- Catppuccin Mocha colors
	color_scheme = "Catppuccin Mocha",

	-- Solid background (no transparency)
	window_background_opacity = 1.0,

	colors = {
		background = "#1e1e2e",
		foreground = "#cdd6f4",
		cursor_bg = "#f5e0dc",
		cursor_fg = "#1e1e2e",
		cursor_border = "#f5e0dc",
		selection_bg = "#45475a",
		selection_fg = "#cdd6f4",
	},
}

local wezterm = require("wezterm")

return {
	enable_wayland = false,

	font = wezterm.font_with_fallback({
		"JetBrains Mono",         
		"Fira Code",              
		"DejaVu Sans Mono",       
		"Symbols Nerd Font Mono", 
		"Noto Color Emoji",       
		"Noto Sans CJK JP",       
	}),

	font_size = 12.0,
	window_background_opacity = 0.8,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
}

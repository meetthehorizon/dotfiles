local wezterm = require 'wezterm'

return {
  enable_wayland = false,

  -- Font
  font = wezterm.font_with_fallback {
    "FantasqueSansM Nerd Font",
    "Noto Color Emoji",
    "Symbols Nerd Font Mono",
  },
  font_size = 12.0,

  -- Enable blur and transparency
  window_background_opacity = 0.8,

  -- Remove tab bar
  enable_tab_bar = false,

  -- Optional: remove window title bar but allow resizing
  window_decorations = "RESIZE",
}


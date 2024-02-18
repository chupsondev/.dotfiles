local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.term = "wezterm"
config.color_scheme = 'Gruvbox Dark (Gogh)'
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
config.font_size = 14

config.window_background_opacity = 0.9

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

return config

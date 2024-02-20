local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.term = "wezterm"
config.color_scheme = 'GruvboxDark'
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
config.font_size = 14

config.window_background_opacity = 0.9

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

config.window_padding = {
    bottom = 0,
}

-- Disable default keybindings, and only enable a few
config.disable_default_key_bindings = true
config.keys = {
    { key = '0', mods = 'SUPER', action = act.ResetFontSize },
    { key = '+', mods = 'SUPER', action = act.IncreaseFontSize },
    { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
    { key = 'l', mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'p', mods = 'SHIFT|CTRL', action = act.ActivateCommandPalette },
    { key = 'q', mods = 'SUPER', action = act.QuitApplication },
    { key = 'v', mods = 'SUPER', action = act.PasteFrom "Clipboard" },
    { key = 'c', mods = 'SUPER', action = act.CopyTo "Clipboard" },
    { key = 'Paste', mods = 'NONE', action = act.PasteFrom "Clipboard" },
    { key = 'Copy', mods = 'NONE', action = act.CopyTo "Clipboard" },
    { key = 'm', mods = 'SUPER', action = act.Hide },
}


return config

local wezterm = require 'wezterm'
local act = wezterm.action

local config = wezterm.config_builder()

config.term = "wezterm"
config.color_scheme = "rose-pine"
config.font = wezterm.font_with_fallback {
    "FiraCode Nerd Font",
    "Symbols Nerd Font"
}
config.font_size = 14

config.window_background_opacity = 0.9

config.enable_tab_bar = false

config.window_decorations = "NONE"

config.window_padding = {
    top = 0,
    bottom = 0,
    left = 8,
    right = 8,
}

-- Disable default keybindings, and only enable a few
config.disable_default_key_bindings = true
config.keys = {
    { key = '0',     mods = 'SUPER',      action = act.ResetFontSize },
    { key = '+',     mods = 'SUPER',      action = act.IncreaseFontSize },
    { key = '-',     mods = 'SUPER',      action = act.DecreaseFontSize },
    { key = 'p',     mods = 'SUPER',      action = act.ActivateCommandPalette },
    { key = 'q',     mods = 'SUPER',      action = act.QuitApplication },
    { key = 'v',     mods = 'SUPER',      action = act.PasteFrom "Clipboard" },
    { key = 'c',     mods = 'SUPER',      action = act.CopyTo "Clipboard" },
    { key = 'v',     mods = 'CTRL|SHIFT',      action = act.PasteFrom "Clipboard" },
    { key = 'c',     mods = 'CTRL|SHIFT',      action = act.CopyTo "Clipboard" },
    { key = 'Paste', mods = 'NONE',       action = act.PasteFrom "Clipboard" },
    { key = 'Copy',  mods = 'NONE',       action = act.CopyTo "Clipboard" },
    { key = 'f',     mods = 'SUPER',      action = act.ToggleFullScreen },
}


return config

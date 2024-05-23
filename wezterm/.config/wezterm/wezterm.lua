local wezterm = require 'wezterm'
local act = wezterm.action

local function get_appearance()
    local theme_file = os.getenv("HOME") .. "/.cache/theme"
    local f = io.open(theme_file, "rb")
    if f then f:close() end
    if f == nil then
        return 'dark'
    end
    local first_line = io.lines(theme_file)()
    if first_line == 'dark' then
        return 'dark'
    elseif first_line == 'light' then
        return 'light'
    end
    return 'dark'
end

local config = wezterm.config_builder()

config.term = "wezterm"
if get_appearance() == 'dark' then
    config.color_scheme = "rose-pine"
else
    config.color_scheme = "rose-pine-dawn"
end
config.font = wezterm.font_with_fallback {
    "FiraCode Nerd Font",
    "Symbols Nerd Font"
}
config.font_size = 14

config.window_background_opacity = 0.9

config.enable_tab_bar = false

config.window_decorations = "RESIZE"

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
    { key = 'l',     mods = 'SHIFT|CTRL', action = act.ShowDebugOverlay },
    { key = 'p',     mods = 'SUPER',      action = act.ActivateCommandPalette },
    { key = 'q',     mods = 'SUPER',      action = act.QuitApplication },
    { key = 'v',     mods = 'SUPER',      action = act.PasteFrom "Clipboard" },
    { key = 'c',     mods = 'SUPER',      action = act.CopyTo "Clipboard" },
    { key = 'Paste', mods = 'NONE',       action = act.PasteFrom "Clipboard" },
    { key = 'Copy',  mods = 'NONE',       action = act.CopyTo "Clipboard" },
    { key = 'm',     mods = 'SUPER',      action = act.Hide },
    { key = 'f',     mods = 'SUPER',      action = act.ToggleFullScreen },
    {
        key = 't',
        mods = 'SUPER',
        action = wezterm.action_callback(function()
            local current_theme = get_appearance()
            local file = io.open(os.getenv("HOME").."/.cache/theme", "w")
            if current_theme == 'dark' then
                file:write("light")
            else
                file:write("dark")
            end
            file:close()
            wezterm.reload_configuration()
        end),
    }
}


return config

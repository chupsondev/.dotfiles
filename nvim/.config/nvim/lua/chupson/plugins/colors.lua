return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = true,
        priority = 1000,
        opts = {
            terminal_colors = true,
            undercurl = true,
            underline = true,
            bold = false,
            italic = {
                strings = false,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true,
            },
            strikethrough = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            inverse = true, -- invert background for search, diffs, statuslines and errors
            contrast = "",  -- can be "hard", "soft" or empty string
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = true,
        }
    },

    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {},
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            transparent = true,
            background = { dark = "wave", light = "lotus" }
        },
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        lazy = true,
        opts = {
            transparent_background = true,
        }
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        lazy = true,
        opts = {
            styles = { transparency = true }
        }
    }
}

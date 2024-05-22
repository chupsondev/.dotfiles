return {
    {
        'ellisonleao/gruvbox.nvim',
        lazy = false,
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
        lazy = false,
        priority = 1000,
        opts = {},
    },

    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            transparent = false,
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
        lazy = false,
        opts = {
            styles = { transparency = true }
        }
    },
    {
        "sainnhe/everforest",
        priority = 1000,
        lazy = false,
        config = function ()
            vim.api.nvim_set_var("everforest_background", "hard")
        end
    }
}

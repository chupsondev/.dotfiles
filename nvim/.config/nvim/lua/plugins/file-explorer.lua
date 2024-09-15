return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["<C-h>"] = false,
                ["<C-l>"] = false,
                ["<C-k>"] = false,
                ["<C-j>"] = false,
            },
        })
        vim.keymap.set('n', '-', ":Oil<CR>", { desc = "Open parent directory", silent = true })
    end
}

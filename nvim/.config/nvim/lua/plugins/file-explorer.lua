return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            view_options = {
                show_hidden = true,
            },
        })
        vim.keymap.set('n', '<leader>ne', ":Oil<CR>", { desc = '[N]etrw [E]xplore', silent = true }) -- It doesn't *actually* open netrw anymore, but that's what it initially stood for and that's what I'm used to
    end
}

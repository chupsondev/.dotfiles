return {
    {
        'akinsho/bufferline.nvim',
        enabled = false,
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            for i = 1, 9 do
                vim.keymap.set("n", "<leader>b" .. i, ":BufferLineGoToBuffer " .. i .. "<CR>", { silent = true })
            end
        end,
    },
}

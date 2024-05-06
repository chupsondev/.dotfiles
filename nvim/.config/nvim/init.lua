-- This config is based on the amazing [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.termguicolors = true
vim.o.background = "dark"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- Colors (per scheme configuration in colors.lua)
vim.cmd.colorscheme("rose-pine")

vim.o.hlsearch = false
vim.o.incsearch = true

vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"

vim.o.clipboard = "unnamedplus"

vim.wo.number = true
vim.wo.relativenumber = true

vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.listchars = "eol:↵,tab:▷ ,extends:◣,precedes:◢,trail:␣,nbsp:○"
vim.o.list = true

vim.o.scrolloff = 5

vim.o.signcolumn = 'yes:2'


vim.o.completeopt = 'menuone,noselect'

vim.o.spell = true
vim.o.spelllang = "en_us,pl"

-- Keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("n", "<leader>p", "\"0p")
vim.keymap.set("n", "<leader>P", "\"0P")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "[B]uffer [D]elete", silent = true })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "[B]uffer [N]ext", silent = true })
vim.keymap.set("n", "[b", ":bprev<CR>", { desc = "[B]uffer [P]revious", silent = true })

-- dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- Disabled in favor of folke/trouble.nvim
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- highlight when yanking
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- For some reason this had some weird stuff going on when it was in its own file, so instead of fixing it I put it back here.
require("bufferline").setup {
    options = {
        numbers = "ordinal"
    }
}

-- This config is based on the amazing [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

require('lazy').setup({
    -- the one and only tpope
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',
    'tpope/vim-vinegar',
    'tpope/vim-surround',

    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {}
    },

    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'williamboman/mason.nvim', config = true },
            'williamboman/mason-lspconfig.nvim',
            { 'j-hui/fidget.nvim',       opts = {} },
        },
    },

    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'rafamadriz/friendly-snippets',
        },
    },

    { 'folke/which-key.nvim',                opts = {} },

    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                icons_enabled = false,
                theme = 'gruvbox',
                component_separators = '|',
                section_separators = '',
            },
        },
    },

    { 'numToStr/Comment.nvim',   opts = {} },

    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
                cond = function()
                    return vim.fn.executable 'make' == 1
                end,
            },
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        dependencies = {
            'nvim-treesitter/nvim-treesitter-textobjects',
        },
        build = ':TSUpdate',
    },

    -- {
    --     "kdheepak/lazygit.nvim",
    --     dependencies = {
    --         "nvim-lua/plenary.nvim",
    --     },
    -- },

    { 'wakatime/vim-wakatime',   lazy = false },

    { 'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons' },

    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
            "BufReadPre " .. vim.fn.expand "~" .. "/Obsidian/**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/Obsidian/**/.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "main",
                    path = "~/Obsidian/",
                },
            },
            disable_frontmatter = true,
            completion = {
                prepend_note_id = false,
                prepend_note_path = true,
            },
        },

        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = { text = '+' },
                    change = { text = '~' },
                    delete = { text = '_' },
                    topdelete = { text = '‾' },
                    changedelete = { text = '~' },
                },
                sign_priority = 100,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map({ 'n', 'v' }, ']c', function()
                        if vim.wo.diff then
                            return ']c'
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Jump to next hunk' })

                    map({ 'n', 'v' }, '[c', function()
                        if vim.wo.diff then
                            return '[c'
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                     end)
                        return '<Ignore>'
                    end, { expr = true, desc = 'Jump to previous hunk' })

                    -- Actions
                    -- visual mode
                    map('v', '<leader>hs', function()
                        gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                    end, { desc = 'stage git hunk' })
                    map('v', '<leader>hr', function()
                        gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                    end, { desc = 'reset git hunk' })
                    -- normal mode
                    map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
                    map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
                    map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
                    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
                    map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
                    map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
                    map('n', '<leader>hb', function()
                        gs.blame_line { full = false }
                    end, { desc = 'git blame line' })
                    map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
                    map('n', '<leader>hD', function()
                        gs.diffthis '~'
                    end, { desc = 'git diff against last commit' })

                    -- Toggles
                    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
                    map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
                end,
            }
        },
    },

    -- require 'chupson.plugins.debug',
    require "chupson.plugins.colors",

}, {})

-- Colors (per scheme configuration in colors.lua)
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd.colorscheme("kanagawa")


vim.o.hlsearch = false
vim.o.incsearch = true

vim.wo.cursorline = true
vim.wo.cursorlineopt = "number"

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

vim.o.scrolloff = 5

vim.o.signcolumn = 'yes:2'


vim.o.completeopt = 'menuone,noselect'

vim.o.spell = true
vim.o.spelllang = "en_us,pl"

-- Set conceal level for obsidian.nvim, only in markdown files
local markdown_settings_group = vim.api.nvim_create_augroup('MarkdownSettings', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    pattern = "markdown",
    callback = function()
        vim.cmd [[setlocal syntax=markdown]]
        vim.cmd [[setlocal conceallevel=1]]
    end,
    group = markdown_settings_group,
})

-- Keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("n", "<leader>p", "\"0p")
vim.keymap.set("n", "<leader>P", "\"0P")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "[B]uffer [D]elete" })

-- NERDTree
vim.keymap.set('n', '<leader>ne', ":Ex<CR>", { desc = '[N]etrw [E]xplore', silent = true })

-- dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- highlight when yanking
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

require('ibl').setup({
    scope = { enabled = false }
})

require('telescope').setup {
    defaults = {
        mappings = {
            i = {
                ['<C-u>'] = false,
                ['<C-d>'] = false,
            },
        },
    },
    pickers = {
        find_files = { find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*", "--glob", "!**/target/*" } }
    },
}

pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == '' then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ':h')
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
    if vim.v.shell_error ~= 0 then
        print 'Not a git repository. Searching on current working directory'
        return cwd
    end
    return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require('telescope.builtin').live_grep {
            search_dirs = { git_root },
        }
    end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })
local function telescope_live_grep_open_files()
    require('telescope.builtin').live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
    }
end
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


vim.defer_fn(function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'vimdoc', 'vim', 'bash' },

        auto_install = false,
        sync_install = false,
        ignore_install = {},
        modules = {},
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = '<c-space>',
                node_incremental = '<c-space>',
                scope_incremental = '<c-s>',
                node_decremental = '<M-space>',
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true,
                keymaps = {
                    ['aa'] = '@parameter.outer',
                    ['ia'] = '@parameter.inner',
                    ['af'] = '@function.outer',
                    ['if'] = '@function.inner',
                    ['ac'] = '@class.outer',
                    ['ic'] = '@class.inner',
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    [']m'] = '@function.outer',
                    [']]'] = '@class.outer',
                },
                goto_next_end = {
                    [']M'] = '@function.outer',
                    [']['] = '@class.outer',
                },
                goto_previous_start = {
                    ['[m'] = '@function.outer',
                    ['[['] = '@class.outer',
                },
                goto_previous_end = {
                    ['[M'] = '@function.outer',
                    ['[]'] = '@class.outer',
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ['<leader>a'] = '@parameter.inner',
                },
                swap_previous = {
                    ['<leader>A'] = '@parameter.inner',
                },
            },
        },
    }
end, 0)

local on_attach = function(_, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

require('which-key').register {
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
    ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}
require('which-key').register({
    ['<leader>'] = { name = 'VISUAL <leader>' },
    ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

require('mason').setup()
require('mason-lspconfig').setup()

local servers = {
    clangd = {},
    pylsp = {
        pylsp = {
            configurationSources = { "pycodestyle", "flake8" },
            plugins = {
                flake8 = {
                    enabled       = true,
                    ignore        = { "F401", "F841" },
                    maxLineLength = 120,
                },
                pycodestyle = {
                    maxLineLength = 120,
                    ignore = { "F841" },
                },
                pyflakes = { enabled = false },
            }
        }
    },
    rust_analyzer = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        }
    end,
}

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = 'menu,menuone,noinsert,noselect',
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = false,
        }
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
    },
}

require("bufferline").setup {
    options = {
        numbers = "ordinal"
    }
}

vim.keymap.set("n", "<leader>[b", ":BufferLineCycleNext<CR>")
vim.keymap.set("n", "<leader>]b", ":BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<leader>1", ":BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<leader>2", ":BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<leader>3", ":BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<leader>4", ":BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<leader>5", ":BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<leader>6", ":BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<leader>7", ":BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<leader>8", ":BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<leader>9", ":BufferLineGoToBuffer 9<CR>")
vim.keymap.set("n", "<leader>$", ":BufferLineGoToBuffer -1<CR>")

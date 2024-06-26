return {
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
        config = function()
            local telescope = require('telescope')
            local telescopeConfig = require("telescope.config")

            local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }
            -- I want to search in hidden/dot files.
            table.insert(vimgrep_arguments, "--hidden")
            -- I don't want to search in the `.git` directory.
            table.insert(vimgrep_arguments, "--glob")
            table.insert(vimgrep_arguments, "!**/.git/*")

            telescope.setup {
                defaults = {
                    mappings = {
                        n = {
                            ['<c-x>'] = require('telescope.actions').delete_buffer,
                        },
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ['<c-x>'] = require('telescope.actions').delete_buffer,
                        },
                    },
                    vimgrep_arguments = vimgrep_arguments,
                    layout_config = {
                        horizontal = { preview_width = 0.6 }
                    },
                },
                pickers = {
                    find_files = { find_command = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*", "--glob", "!**/target/*" } }
                },
            }

            pcall(require('telescope').load_extension, 'fzf')

            local find_dirs = function(opts)
                require("telescope.pickers").new({}, {
                    prompt_title = "Open Directory",
                    finder = require("telescope.finders").new_table({
                        results = vim.fn.systemlist("fd . --type d --color never --follow --hidden")
                    }),
                    previewer = require("telescope.previewers").vim_buffer_cat.new({}),
                    sorter = require("telescope.sorters").get_fuzzy_file(),
                    attach_mappings = function(prompt_bufnr)
                        require("telescope.actions.set").select:replace(function(_)
                            local entry = require("telescope.actions.state").get_selected_entry()
                            require("telescope.actions").close(prompt_bufnr)
                            local oil = require("oil")
                            oil.open(entry[1])
                        end)
                        return true
                    end,
                    }):find()
            end

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
                local git_root = vim.fn.systemlist('git -C ' ..
                    vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
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


            vim.keymap.set('n', '<leader>sd', find_dirs, { desc = '[S]earch [D]irectories' })


            vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
                { desc = '[?] Find recently opened files' })
            vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
                { desc = '[ ] Find existing buffers' })
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
            vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin,
                { desc = '[S]earch [S]elect Telescope' })
            vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
            vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
            vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
            vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
                { desc = '[S]earch current [W]ord' })
            vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
            vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
            vim.keymap.set('n', '<leader>sk', require('telescope.builtin').keymaps, { desc = '[S]earch [K]eymaps' })
            vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
        end
    },
}

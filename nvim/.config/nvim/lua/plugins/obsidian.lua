return {
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "/Obsidian/**.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/Obsidian/**.md",
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("obsidian").setup({
                workspaces = {
                    {
                        name = "main",
                        path = "~/Obsidian/",
                    },
                },
                disable_frontmatter = true,
                wiki_link_func = function(opts)
                    if opts.label ~= opts.path then
                        return string.format("[[%s|%s]]", opts.path, opts.label)
                    else
                        return string.format("[[%s]]", opts.path)
                    end
                end,
            })
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
        end
    },
}

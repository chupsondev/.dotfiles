return {
    "lervag/vimtex",
    lazy = false,
    init = function()
        vim.g.vimtex_view_method = "zathura"
        vim.g.vimtex_compiler_latexmk = { out_dir = "target" }
        vim.g.vimtex_quickfix_autoclose_after_keystrokes = 1
        vim.g.vimtex_quickfix_open_on_warning = 0
    end
}

return {
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = function()
            local npairs = require("nvim-autopairs")
            local Rule = require('nvim-autopairs.rule')
            npairs.setup({})

            local cond = require('nvim-autopairs.conds')
            npairs.add_rule(Rule("<", ">"):with_pair(cond.before_regex("[a-zA-Z0-9:<>]+")):with_move(function(opts) return
                opts.char == ">" end))
        end
    },
}

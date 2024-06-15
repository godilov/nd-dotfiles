local cmp       = require 'cmp'
local snip      = require 'luasnip'
local tree      = require 'nvim-tree.api'
local telescope = require 'telescope'
local actions   = require 'telescope.actions'
local inlay     = require 'lsp-inlayhints'

return {
    ['nd-even'] = {
        scheme = 'nd-even',
        leader = {
            files    = ';',
            lsp_goto = 'g',
            lsp      = ' ',
        },
        opts = {
            noremap = true,
        },
        api = {
            nvim      = vim,
            cmp       = cmp,
            snip      = snip,
            tree      = tree,
            telescope = telescope,
            actions   = actions,
            inlay     = inlay,
        },
    },
}

local fn_lib         = require 'nd.lib.fn'
local str_lib        = require 'nd.lib.str'
local cache_lib      = require 'nd.lib.cache'

local plugins_fn     = require 'nd.nvim.res.plugins'

local res_config     = require 'nd.nvim.config.res'

local options_fn     = require 'nd.nvim.options'
local commands_fn    = require 'nd.nvim.commands'
local navigation_fn  = require 'nd.nvim.navigation'
local development_fn = require 'nd.nvim.development'
local appearance_fn  = require 'nd.nvim.appearance'

local cmp            = require 'cmp'
local snip           = require 'luasnip'
local tree           = require 'nvim-tree.api'
local telescope      = require 'telescope'
local actions        = require 'telescope.actions'
local inlay          = require 'lsp-inlayhints'

local ivals          = fn_lib.ivals
local map            = fn_lib.map
local collect        = fn_lib.collect

local concat2s       = str_lib.concat2s
local concat3s       = str_lib.concat3s

local packer         = require 'packer'

local is_init        = false

local concat_elem    = nil


concat_elem = function(elem)
    return concat3s(elem[1], '/', elem[2])
end

return function()
    if not is_init then
        cache_lib.fs.set_dir(concat2s(vim.fn.stdpath 'cache', '/nd.nvim/'))

        packer.startup {
            collect(map(concat_elem, ivals(plugins_fn()))),
        }

        local config = {
            colors = {
                scheme = 'nd-even',
            },
            keys   = {
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
            lsp    = {
                lua = {
                    libs = {
                        '/usr/share/nvim/runtime/lua',
                        '/usr/share/nvim/runtime/lua/lsp',
                    },
                    globals = {
                        'vim',
                        'screen',
                        'client',
                        'root',
                    },
                },
            },
            res    = res_config['nd-even'],
        }

        options_fn(config)
        commands_fn(config)
        navigation_fn(config)
        development_fn(config)
        appearance_fn(config)

        is_init = true
    end
end

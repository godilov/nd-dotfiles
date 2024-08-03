local fn_lib         = require 'nd.lib.fn'
local str_lib        = require 'nd.lib.str'
local cache_lib      = require 'nd.lib.cache'

local plugins_fn     = require 'nd.nvim.res.plugins'

local options_fn     = require 'nd.nvim.options'
local commands_fn    = require 'nd.nvim.commands'
local navigation_fn  = require 'nd.nvim.navigation'
local development_fn = require 'nd.nvim.development'
local appearance_fn  = require 'nd.nvim.appearance'

local ivals          = fn_lib.ivals
local map            = fn_lib.map
local collect        = fn_lib.collect

local concat2s       = str_lib.concat2s
local concat3s       = str_lib.concat3s

local is_init        = false

local concat_elem    = nil

local init           = nil


concat_elem = function(elem)
    return concat3s(elem[1], '/', elem[2])
end

init = function()
    require 'packer'.startup {
        collect(map(concat_elem, ivals(plugins_fn()))),
    }
end

return function()
    if not is_init then
        cache_lib.fs.set_dir(concat2s(vim.fn.stdpath 'cache', '/nd.nvim/'))

        if not pcall(init) then
            return
        end

        local status, config = pcall(function()
            return {
                colors = {
                    scheme = 'even',
                },
                keys   = {
                    scheme = 'even',
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
                        cmp       = require 'cmp',
                        snip      = require 'luasnip',
                        tree      = require 'nvim-tree.api',
                        telescope = require 'telescope',
                        actions   = require 'telescope.actions',
                        inlay     = require 'lsp-inlayhints',
                    },
                },
                lsp    = {
                    lua = {
                        libs = {
                            '/usr/share/nvim/runtime/lua',
                            '/usr/share/nvim/runtime/lua/lsp',

                            '~/.local/share/nvim/site/pack/packer/start',
                        },
                        globals = {
                            'vim',
                            'screen',
                            'client',
                            'root',
                        },
                    },
                },
            }
        end)

        if status then
            options_fn(config)
            commands_fn(config)
            navigation_fn(config)
            development_fn(config)
            appearance_fn(config)
        end

        is_init = true
    end
end

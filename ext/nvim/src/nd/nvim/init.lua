local fn_lib         = require 'nd.lib.fn'
local str_lib        = require 'nd.lib.str'
local cache_lib      = require 'nd.lib.cache'

local plugin_fn      = require 'nd.res.plugins'

local keys_config    = require 'nd.nvim.config.keys'
local colors_config  = require 'nd.nvim.config.colors'
local lsp_config     = require 'nd.nvim.config.lsp'
local res_config     = require 'nd.nvim.config.res'

local option_fn      = require 'nd.nvim.option'
local command_fn     = require 'nd.nvim.command'
local navigation_fn  = require 'nd.nvim.navigation'
local development_fn = require 'nd.nvim.development'
local appearance_fn  = require 'nd.nvim.appearance'

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

        local plugins = plugin_fn()

        packer.startup {
            collect(map(concat_elem, ivals(plugins))),
        }

        local config = {
            keys   = keys_config['main'],
            colors = colors_config['main'],
            lsp    = lsp_config['main'],
            res    = res_config['main'],
        }

        option_fn()
        command_fn(config)
        navigation_fn(config)
        development_fn(config)
        appearance_fn(config)

        is_init = true
    end
end

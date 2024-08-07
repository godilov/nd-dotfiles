local type_lib      = require 'nd.lib.type'
local assert_lib    = require 'nd.lib.assert'

local is_tab        = type_lib.is_tab

local nd_assert     = assert_lib.get_fn(ND_NVIM_IS_DEBUG)

local lsp_fn        = require 'nd.nvim.res.keys.even.lsp'
local lsp_buf_fn    = require 'nd.nvim.res.keys.even.lsp_buf'
local editor_fn     = require 'nd.nvim.res.keys.even.editor'

local treesitter_fn = require 'nd.nvim.res.keys.even.ext.treesitter'
local telescope_fn  = require 'nd.nvim.res.keys.even.ext.telescope'
local tree_fn       = require 'nd.nvim.res.keys.even.ext.tree'
local cmp_fn        = require 'nd.nvim.res.keys.even.ext.cmp'

return function(config)
    nd_assert(is_tab(config), 'config must be of type table')
    nd_assert(is_tab(config.api), 'api must be of type table')
    nd_assert(is_tab(config.leader), 'leader must be of type table')
    nd_assert(is_tab(config.opts) or not config.opts, 'opts must be of type table or nil')

    return {
        lsp_fn        = lsp_fn(config),
        lsp_buf_fn    = lsp_buf_fn(config),
        editor_fn     = editor_fn(config),
        treesitter_fn = treesitter_fn(config),
        telescope_fn  = telescope_fn(config),
        tree_fn       = tree_fn(config),
        cmp_fn        = cmp_fn(config),
    }
end

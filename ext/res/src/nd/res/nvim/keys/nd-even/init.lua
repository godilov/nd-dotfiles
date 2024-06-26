local type_lib      = require 'nd.lib.type'
local assert_lib    = require 'nd.lib.assert'

local is_tab        = type_lib.is_tab

local nd_assert     = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err        = assert_lib.get_err_fn 'nd.res.nvim.keys.nd-even'

local lsp_fn        = require 'nd.res.nvim.keys.nd-even.lsp'
local lsp_buf_fn    = require 'nd.res.nvim.keys.nd-even.lsp_buf'
local editor_fn     = require 'nd.res.nvim.keys.nd-even.editor'

local treesitter_fn = require 'nd.res.nvim.keys.nd-even.ext.treesitter'
local telescope_fn  = require 'nd.res.nvim.keys.nd-even.ext.telescope'
local tree_fn       = require 'nd.res.nvim.keys.nd-even.ext.tree'
local cmp_fn        = require 'nd.res.nvim.keys.nd-even.ext.cmp'

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')
    nd_assert(is_tab(config.api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(config.leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_tab(config.opts) or not config.opts, nd_err, 'fn(): opts must be of type table or nil')

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

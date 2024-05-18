local tab_lib       = require 'nd.lib.core.tab'
local type_lib      = require 'nd.lib.core.type'
local assert_lib    = require 'nd.lib.core.assert'

local concat        = tab_lib.concat

local is_tab        = type_lib.is_tab

local nd_assert     = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err        = assert_lib.get_err_fn 'nd.res.core.color.nvim.highlight.main'

local editor_fn     = require 'nd.res.core.color.nvim.highlight.main.editor'
local syntax_fn     = require 'nd.res.core.color.nvim.highlight.main.syntax'

local packer_fn     = require 'nd.res.core.color.nvim.highlight.main.ext.packer'
local treesitter_fn = require 'nd.res.core.color.nvim.highlight.main.ext.treesitter'
local telescope_fn  = require 'nd.res.core.color.nvim.highlight.main.ext.telescope'
local tree_fn       = require 'nd.res.core.color.nvim.highlight.main.ext.tree'
local cmp_fn        = require 'nd.res.core.color.nvim.highlight.main.ext.cmp'

return function(config)
    nd_assert(is_tab(config.palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(config.accent), nd_err, 'fn(): accent must be of type table')

    return concat {
        editor_fn(config),
        syntax_fn(config),
        packer_fn(config),
        treesitter_fn(config),
        telescope_fn(config),
        tree_fn(config),
        cmp_fn(config),
    }
end

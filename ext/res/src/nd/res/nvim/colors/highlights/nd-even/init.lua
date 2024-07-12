local tab_lib       = require 'nd.lib.tab'
local type_lib      = require 'nd.lib.type'
local assert_lib    = require 'nd.lib.assert'

local concat        = tab_lib.concat

local is_tab        = type_lib.is_tab

local nd_assert     = assert_lib.get_fn(ND_RES_IS_DEBUG)

local editor_fn     = require 'nd.res.nvim.colors.highlights.nd-even.editor'
local syntax_fn     = require 'nd.res.nvim.colors.highlights.nd-even.syntax'

local packer_fn     = require 'nd.res.nvim.colors.highlights.nd-even.ext.packer'
local treesitter_fn = require 'nd.res.nvim.colors.highlights.nd-even.ext.treesitter'
local telescope_fn  = require 'nd.res.nvim.colors.highlights.nd-even.ext.telescope'
local tree_fn       = require 'nd.res.nvim.colors.highlights.nd-even.ext.tree'
local cmp_fn        = require 'nd.res.nvim.colors.highlights.nd-even.ext.cmp'

return function(config)
    nd_assert(is_tab(config.palette), 'palette must be of type table')
    nd_assert(is_tab(config.accent), 'accent must be of type table')

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

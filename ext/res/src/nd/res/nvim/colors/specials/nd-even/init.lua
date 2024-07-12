local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)

local lualine_fn = require 'nd.res.nvim.colors.specials.nd-even.lualine'

return function(scheme)
    nd_assert(is_tab(scheme.palette), 'palette must be of type table')
    nd_assert(is_tab(scheme.accent), 'accent must be of type table')
    nd_assert(is_tab(scheme.highlight), 'highlight must be of type table')

    return {
        lualine = lualine_fn(scheme),
    }
end

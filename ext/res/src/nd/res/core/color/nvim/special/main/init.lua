local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.special.main'

local lualine_fn = require 'nd.res.core.color.nvim.special.main.lualine'

return function(scheme)
    nd_assert(is_tab(scheme.palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(scheme.accent), nd_err, 'fn(): accent must be of type table')
    nd_assert(is_tab(scheme.highlight), nd_err, 'fn(): highlight must be of type table')

    return {
        lualine = lualine_fn(scheme),
    }
end

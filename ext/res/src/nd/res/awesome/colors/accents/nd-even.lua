local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.awesome.colors.accents.nd-even'

return function(config)
    local palette = config.palette

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')

    return {
        core     = palette.black,
        emphasis = palette.yellow,
        text     = palette.white,
    }
end

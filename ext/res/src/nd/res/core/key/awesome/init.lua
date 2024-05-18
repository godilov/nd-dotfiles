local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local load_fn    = require 'nd.res.core.load'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.awesome'

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')

    nd_assert(config.scheme, nd_err, 'fn(): scheme must be of type value')

    nd_assert(is_tab(config.api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(config.mod), nd_err, 'fn(): mod must be of type table')
    nd_assert(is_tab(config.event), nd_err, 'fn(): event must be of type table')

    return load_fn('nd.res.core.key.awesome', config.scheme, config)
end

local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local load_fn    = require 'nd.res.core.load'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim'

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')

    nd_assert(config.scheme, nd_err, 'fn(): scheme must be of type value')

    nd_assert(is_tab(config.api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(config.leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_tab(config.opts) or not config.opts, nd_err, 'fn(): opts must be of type table or nil')

    return load_fn('nd.res.core.key.nvim', config.scheme, config)
end

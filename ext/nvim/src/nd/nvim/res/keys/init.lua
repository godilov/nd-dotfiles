local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local load_fn    = require 'nd.nvim.res.load'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)

return function(config)
    nd_assert(is_tab(config), 'config must be of type table')

    nd_assert(config.scheme, 'scheme must be of type value')

    nd_assert(is_tab(config.api), 'api must be of type table')
    nd_assert(is_tab(config.leader), 'leader must be of type table')
    nd_assert(is_tab(config.opts) or not config.opts, 'opts must be of type table or nil')

    return load_fn('nd.nvim.res.keys', config.scheme, config)
end

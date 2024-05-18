local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab
local is_fn      = type_lib.is_fn

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.load'

local format     = string.format

return function(scope, config, ...)
    if is_str(config) then
        return require(format('%s.%s', scope, config))(...)
    elseif is_tab(config) then
        return config
    elseif is_fn(config) then
        return config(...)
    else
        nd_assert(false, nd_err, 'load(): config must be of type string, table or function')
    end
end

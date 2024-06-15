local type_lib    = require 'nd.lib.type'
local assert_lib  = require 'nd.lib.assert'

local nvim_fn     = require 'nd.res.keys.nvim'
local keys_cache  = require 'nd.res.keys_cache'

local is_str      = type_lib.is_str
local is_tab      = type_lib.is_tab

local nd_assert   = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err      = assert_lib.get_err_fn 'nd.res.nvim.keys.cache'

local get_keyname = keys_cache.get_keyname
local get_scheme  = keys_cache.get_scheme


local get = nil


get = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get(): config must be of type table')

    local scheme   = config.scheme
    local scheme_n = is_str(scheme) and scheme or config.scheme_name

    nd_assert(is_str(scheme_n), nd_err, 'get(): scheme or scheme_name must be of type string')

    local key = get_keyname { 'nvim', scheme_n }

    return get_scheme(nvim_fn, config, key, is_forced)
end

return {
    get = get,
}

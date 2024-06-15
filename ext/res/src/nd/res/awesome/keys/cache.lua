local type_lib    = require 'nd.lib.type'
local assert_lib  = require 'nd.lib.assert'

local cache       = require 'nd.res.cache.keys'
local awesome_fn  = require 'nd.res.keys.awesome'

local is_str      = type_lib.is_str
local is_tab      = type_lib.is_tab

local nd_assert   = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err      = assert_lib.get_err_fn 'nd.res.awesome.keys.cache'

local get_keyname = cache.get_keyname
local get_scheme  = cache.get_scheme


local get = nil


get = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get(): config must be of type table')

    local scheme   = config.scheme
    local scheme_n = is_str(scheme) and scheme or config.scheme_name

    nd_assert(is_str(scheme_n), nd_err, 'get(): scheme or scheme_name must be of type string')

    local key = get_keyname { 'awesome', scheme_n }

    return get_scheme(awesome_fn, config, key, is_forced)
end

return {
    get = get,
}

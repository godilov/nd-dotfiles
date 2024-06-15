local type_lib    = require 'nd.lib.type'
local assert_lib  = require 'nd.lib.assert'

local cache       = require 'nd.res.cache.colors'
local awesome_fn  = require 'nd.res.colors.awesome'

local is_str      = type_lib.is_str
local is_tab      = type_lib.is_tab

local nd_assert   = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err      = assert_lib.get_err_fn 'nd.res.awesome.colors.cache'

local get_keyname = cache.get_keyname
local get_scheme  = cache.get_scheme


local get = nil


get = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get(): config must be of type table')

    local palette   = config.palette
    local accent    = config.accent
    local scheme_n  = config.scheme
    local palette_n = is_str(palette) and palette or config.palette_name or scheme_n
    local accent_n  = is_str(accent) and accent or config.accent_name or scheme_n

    nd_assert(is_str(scheme_n) or not scheme_n, nd_err, 'get(): scheme must be of type string or nil')

    nd_assert(is_str(palette_n), nd_err, 'get(): palette or palette_name or scheme must be of type string')
    nd_assert(is_str(accent_n), nd_err, 'get(): accent or accent_name or scheme must be of type string')

    local key = get_keyname { 'awesome', palette_n, accent_n }

    return get_scheme(awesome_fn, config, key, is_forced)
end

return {
    get = get,
}

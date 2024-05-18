local str_lib    = require 'nd.lib.core.str'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'
local cache_lib  = require 'nd.lib.cache.mem'

local awesome_fn = require 'nd.res.core.key.awesome'
local nvim_fn    = require 'nd.res.core.key.nvim'

local concat3s   = str_lib.concat3s

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.key.cache'

local set        = cache_lib.set
local get        = cache_lib.get


local get_keyname      = nil
local get_scheme       = nil
local get_scheme_cache = nil
local get_awesome      = nil
local get_nvim         = nil


get_keyname = function(type, scheme)
    return concat3s(type, '-', scheme)
end

get_scheme = function(fn, config, key)
    local scheme = fn(config)

    set(key, scheme)

    return scheme
end

get_scheme_cache = function(fn, config, key, is_forced)
    if is_forced then
        return get_scheme(fn, config, key)
    else
        local scheme_cache = get(key)

        return is_tab(scheme_cache) and scheme_cache or
            get_scheme(fn, config, key)
    end
end

get_awesome = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get_awesome(): config must be of type table')

    local scheme   = config.scheme
    local scheme_n = is_str(scheme) and scheme or config.scheme_name

    nd_assert(is_str(scheme_n), nd_err, 'get_awesome(): scheme or scheme_name must be of type string')

    local key = get_keyname { 'awesome', scheme_n }

    return get_scheme_cache(awesome_fn, config, key, is_forced)
end

get_nvim = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get_nvim(): config must be of type table')

    local scheme   = config.scheme
    local scheme_n = is_str(scheme) and scheme or config.scheme_name

    nd_assert(is_str(scheme_n), nd_err, 'get_nvim(): scheme or scheme_name must be of type string')

    local key = get_keyname { 'nvim', scheme_n }

    return get_scheme_cache(nvim_fn, config, key, is_forced)
end

return {
    get_awesome = get_awesome,
    get_nvim    = get_nvim,
}

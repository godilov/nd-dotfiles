local str_lib    = require 'nd.lib.core.str'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'
local cache_lib  = require 'nd.lib.cache.fs'

local awesome_fn = require 'nd.res.core.color.awesome'
local nvim_fn    = require 'nd.res.core.color.nvim'

local concat2s   = str_lib.concat2s

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.color.cache'

local set        = cache_lib.set
local get        = cache_lib.get

local concat     = table.concat


local get_keyname      = nil
local get_scheme       = nil
local get_scheme_cache = nil
local get_awesome      = nil
local get_nvim         = nil


get_keyname = function(strs)
    return concat2s(concat(strs, '-'), '.lua')
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

    local palette   = config.palette
    local accent    = config.accent
    local scheme_n  = config.scheme
    local palette_n = is_str(palette) and palette or config.palette_name or scheme_n
    local accent_n  = is_str(accent) and accent or config.accent_name or scheme_n

    nd_assert(is_str(scheme_n) or not scheme_n, nd_err, 'get_awesome(): scheme must be of type string or nil')

    nd_assert(is_str(palette_n), nd_err, 'get_awesome(): palette or palette_name or scheme must be of type string')
    nd_assert(is_str(accent_n), nd_err, 'get_awesome(): accent or accent_name or scheme must be of type string')

    local key = get_keyname { 'awesome', palette_n, accent_n }

    return get_scheme_cache(awesome_fn, config, key, is_forced)
end

get_nvim = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get_nvim(): config must be of type table')

    local palette     = config.palette
    local accent      = config.accent
    local highlight   = config.highlight
    local scheme_n    = config.scheme
    local palette_n   = is_str(palette) and palette or config.palette_name or scheme_n
    local accent_n    = is_str(accent) and accent or config.accent_name or scheme_n
    local highlight_n = is_str(highlight) and highlight or config.highlight_name or scheme_n

    nd_assert(is_str(scheme_n) or not scheme_n, nd_err, 'get_nvim(): scheme must be of type string or nil')

    nd_assert(is_str(palette_n), nd_err, 'get_nvim(): palette or palette_name or scheme must be of type string')
    nd_assert(is_str(accent_n), nd_err, 'get_nvim(): accent or accent_name or scheme must be of type string')
    nd_assert(is_str(highlight_n), nd_err, 'get_nvim(): highlight or highlight_name or scheme must be of type string')

    local key = get_keyname { 'nvim', palette_n, accent_n, highlight_n }

    return get_scheme_cache(nvim_fn, config, key, is_forced)
end

return {
    get_awesome = get_awesome,
    get_nvim    = get_nvim,
}

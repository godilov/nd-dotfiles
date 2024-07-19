local str_lib    = require 'nd.lib.str'
local type_lib   = require 'nd.lib.type'
local cache_lib  = require 'nd.lib.cache'
local assert_lib = require 'nd.lib.assert'

local colors_fn  = require 'nd.res.nvim.colors'
local keys_fn    = require 'nd.res.nvim.keys'

local concat2s   = str_lib.concat2s
local concat3s   = str_lib.concat3s

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local set        = cache_lib.fs.set
local get        = cache_lib.fs.get

local concat     = table.concat

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)


local get_colors_keyname    = nil
local get_colors_scheme_raw = nil
local get_colors_scheme     = nil
local get_keys_keyname      = nil
local get_keys_scheme_raw   = nil
local get_keys_scheme       = nil

local get_colors            = nil
local get_keys              = nil


get_colors_keyname = function(strs)
    return concat2s(concat(strs, '-'), '.lua')
end

get_keys_keyname = function(type, scheme)
    return concat3s(type, '-', scheme)
end

get_colors_scheme_raw = function(fn, config, key)
    local scheme = fn(config)

    set(key, scheme)

    return scheme
end

get_keys_scheme_raw = function(fn, config, key)
    local scheme = fn(config)

    set(key, scheme)

    return scheme
end

get_colors_scheme = function(fn, config, key, is_forced)
    if is_forced then
        return get_colors_scheme_raw(fn, config, key)
    else
        local scheme_cache = get(key)

        return is_tab(scheme_cache) and scheme_cache or
            get_colors_scheme_raw(fn, config, key)
    end
end

get_keys_scheme = function(fn, config, key, is_forced)
    if is_forced then
        return get_keys_scheme_raw(fn, config, key)
    else
        local scheme_cache = get(key)

        return is_tab(scheme_cache) and scheme_cache or
            get_keys_scheme_raw(fn, config, key)
    end
end

get_colors = function(config, is_forced)
    nd_assert(is_tab(config), 'config must be of type table')

    local palette     = config.palette
    local accent      = config.accent
    local highlight   = config.highlight
    local scheme_n    = config.scheme
    local palette_n   = is_str(palette) and palette or config.palette_name or scheme_n
    local accent_n    = is_str(accent) and accent or config.accent_name or scheme_n
    local highlight_n = is_str(highlight) and highlight or config.highlight_name or scheme_n

    nd_assert(is_str(scheme_n) or not scheme_n, 'scheme must be of type string or nil')

    nd_assert(is_str(palette_n), 'palette or palette_name or scheme must be of type string')
    nd_assert(is_str(accent_n), 'accent or accent_name or scheme must be of type string')
    nd_assert(is_str(highlight_n), 'highlight or highlight_name or scheme must be of type string')

    local key = get_colors_keyname { 'nvim', palette_n, accent_n, highlight_n }

    return get_colors_scheme(colors_fn, config, key, is_forced)
end

get_keys = function(config, is_forced)
    nd_assert(is_tab(config), 'config must be of type table')

    local scheme   = config.scheme
    local scheme_n = is_str(scheme) and scheme or config.scheme_name

    nd_assert(is_str(scheme_n), 'scheme or scheme_name must be of type string')

    local key = get_keys_keyname { 'nvim', scheme_n }

    return get_keys_scheme(keys_fn, config, key, is_forced)
end

return {
    get_colors = get_colors,
    get_keys   = get_keys,
}

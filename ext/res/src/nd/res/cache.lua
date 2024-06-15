local str_lib   = require 'nd.lib.str'
local type_lib  = require 'nd.lib.type'
local cache_lib = require 'nd.lib.cache'

local concat2s  = str_lib.concat2s
local concat3s  = str_lib.concat3s

local is_tab    = type_lib.is_tab

local set       = cache_lib.fs.set
local get       = cache_lib.fs.get

local concat    = table.concat


local get_colors_keyname    = nil
local get_colors_scheme_raw = nil
local get_colors_scheme     = nil
local get_keys_keyname      = nil
local get_keys_scheme_raw   = nil
local get_keys_scheme       = nil


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

return {
    get_colors_keyname = get_colors_keyname,
    get_colors_scheme  = get_colors_scheme,
    get_keys_keyname   = get_keys_keyname,
    get_keys_scheme    = get_keys_scheme,
}

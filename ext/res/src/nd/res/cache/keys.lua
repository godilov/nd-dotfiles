local str_lib   = require 'nd.lib.str'
local type_lib  = require 'nd.lib.type'
local cache_lib = require 'nd.lib.cache'

local concat3s  = str_lib.concat3s

local is_tab    = type_lib.is_tab

local set       = cache_lib.mem.set
local get       = cache_lib.mem.get


local get_keyname    = nil
local get_scheme_raw = nil
local get_scheme     = nil


get_keyname = function(type, scheme)
    return concat3s(type, '-', scheme)
end

get_scheme_raw = function(fn, config, key)
    local scheme = fn(config)

    set(key, scheme)

    return scheme
end

get_scheme = function(fn, config, key, is_forced)
    if is_forced then
        return get_scheme_raw(fn, config, key)
    else
        local scheme_cache = get(key)

        return is_tab(scheme_cache) and scheme_cache or
            get_scheme_raw(fn, config, key)
    end
end

return {
    get_keyname = get_keyname,
    get_scheme  = get_scheme,
}

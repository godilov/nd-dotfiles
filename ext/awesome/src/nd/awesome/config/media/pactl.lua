local fn_lib      = require 'nd.lib.fn'
local str_lib     = require 'nd.lib.str'
local math_lib    = require 'nd.lib.math'

local map         = fn_lib.map
local filter      = fn_lib.filter
local reduce      = fn_lib.reduce

local starts      = str_lib.starts
local split_it    = str_lib.split_it
local split       = str_lib.split
local trim        = str_lib.trim

local clamp       = math_lib.clamp

local format      = string.format
local match       = string.match

local tonumber    = tonumber

local awful       = require 'awful'

local spawn       = awful.spawn
local easy_async  = awful.spawn.easy_async

local enum_reduce = nil
local enum_filter = nil
local enum_trim   = nil
local enum_fn     = nil
local enum        = nil
local get_fn      = nil
local get         = nil
local get_val_fn  = nil
local get_val     = nil
local set_val     = nil
local set_dev     = nil
local add         = nil
local mute        = nil


enum_reduce = function(t, elem)
    local elems = split(elem, ': ')

    t[elems[1]] = elems[2]

    return t
end

enum_filter = function(elem)
    return starts(elem, 'Name|Description|Volume')
end

enum_trim = function(elem)
    return trim(elem, '[\t ]')
end

enum_fn = function(fn)
    return function(out, _, _, code)
        if code == 0 then
            fn(reduce(enum_reduce, {}, filter(enum_filter, map(enum_trim, split_it(out, '\n')))))
        end
    end
end

enum = function(fn)
    easy_async('pactl list sinks | grep "(Name|Description|Volume)"', enum_fn(fn))
end

get_fn = function(fn)
    return function(out, _, _, code)
        if code == 0 then
            fn(out)
        end
    end
end

get = function(fn)
    easy_async('pactl get-default-sink', get_fn(fn))
end

get_val_fn = function(fn)
    return function(out, _, _, code)
        if code == 0 then
            fn(tonumber(match(split(out, '/')[2], '[0-9]+')))
        end
    end
end

get_val = function(id, fn)
    easy_async(format('pactl get-sink-volume %s', id or '@DEFAULT_SINK@'), get_val_fn(fn))
end

set_val = function(id, val)
    spawn(format('pactl set-sink-volume %s %s%%', id or '@DEFAULT_SINK@', clamp(val, 0, 100)))
end

set_dev = function(id)
    spawn(format('pactl set-default-sink %s', id))
end

add = function(id, val)
    get_val(id, function(now)
        set_val(id, now + val)
    end)
end

mute = function(id)
    easy_async(format('pactl set-sink-mute %s toggle', id or '@DEFAULT_SINK@'))
end

return {
    enum    = enum,
    get     = get,
    get_val = get_val,
    set_val = set_val,
    set_dev = set_dev,
    add     = add,
    mute    = mute,
}

local fn_lib     = require 'nd.lib.core.fn'
local math_lib   = require 'nd.lib.core.math'

local it         = fn_lib.it
local collect    = fn_lib.collect

local clamp      = math_lib.clamp

local format     = string.format
local gmatch     = string.gmatch

local abs        = math.abs

local tonumber   = tonumber

local awful      = require 'awful'

local spawn      = awful.spawn
local easy_async = awful.spawn.easy_async


local enum_fn    = nil
local enum       = nil
local get_val_fn = nil
local get_val    = nil
local set_val    = nil
local add        = nil


enum_fn = function(fn)
    return function(out, _, _, code)
        if code == 0 then
            fn(collect(it(gmatch(out, '[^%s]+'))))
        end
    end
end

enum = function(fn)
    easy_async('ls /sys/class/backlight/', enum_fn(fn))
end

get_val_fn = function(fn)
    return function(out, _, _, code)
        if code == 0 then
            fn(tonumber(out))
        end
    end
end

get_val = function(fn)
    easy_async('light -G', get_val_fn(fn))
end

set_val = function(val)
    spawn(format('light -S %s', clamp(val, 0, 100)))
end

add = function(val)
    spawn(format('light %s %s', (val or 0) >= 0 and '-A' or '-U', abs(val)))
end

return {
    enum    = enum,
    get_val = get_val,
    set_val = set_val,
    add     = add,
}

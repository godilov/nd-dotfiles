local fn_lib     = require 'nd.lib.fn'
local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local nd_assert  = assert_lib.get_fn(ND_LIB_IS_DEBUG)

local ivals      = fn_lib.ivals
local each       = fn_lib.each

local is_str     = type_lib.is_str
local is_fn      = type_lib.is_fn

local format     = string.format


local events      = {}
local key         = nil
local subscribe   = nil
local notify_each = nil
local notify      = nil


key = function(scope, name)
    return format('%s.%s', scope, name)
end

subscribe = function(scope, name, fn)
    nd_assert(is_str(scope), 'scope must be of type string')
    nd_assert(is_str(name), 'name must be of type string')
    nd_assert(is_fn(fn), 'fn must be of type function')

    local k = key(scope, name)

    local event = events[k]

    if not event then
        events[k] = {}
    end

    event[#event + 1] = fn
end

notify_each = function(args)
    return function(fn)
        fn(args)
    end
end

notify = function(scope, name, args)
    nd_assert(is_str(scope), 'scope must be of type string')
    nd_assert(is_str(name), 'name must be of type string')

    local event = events[key(scope, name)]

    if event then
        each(notify_each(args), ivals(event))
    end
end

return {
    subscribe = subscribe,
    notify    = notify,
}

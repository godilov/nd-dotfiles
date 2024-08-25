local type_lib      = require 'nd.lib.type'
local assert_lib    = require 'nd.lib.assert'

local is_num        = type_lib.is_num
local is_tab        = type_lib.is_tab
local is_fn         = type_lib.is_fn

local nd_assert     = assert_lib.get_fn(ND_LIB_IS_DEBUG)

local next_fn       = next

local is_iter       = nil
local as_iter       = nil
local empty_next    = nil
local range_v_next  = nil
local range_iv_next = nil
local iv_next       = nil
local kv_next       = nil
local keys_next     = nil
local mapi_fn       = nil
local mapk_fn       = nil
local self          = nil

local empty         = nil
local range_v       = nil
local range_iv      = nil
local it            = nil
local iv            = nil
local kv            = nil
local keys          = nil
local ivals         = nil
local kvals         = nil
local mapi          = nil
local mapk          = nil

local map           = nil
local filter        = nil
local reduce        = nil
local concat        = nil
local zip           = nil
local take          = nil
local skip          = nil
local distinct      = nil
local group         = nil
local count         = nil
local all           = nil
local any           = nil
local add           = nil
local remove        = nil
local collect       = nil
local each          = nil
local pipe          = nil



local iter_mt = {
    __call = function(iter)
        return iter[1], iter[2], iter[3]
    end,
    __mul = function(x, fn)
        local is_x_iter = is_iter(x)
        local is_x_fn   = is_fn(x)

        nd_assert((is_x_iter or is_x_fn) and is_fn(fn),
            'x must be of type iter or function and fn must be of type function')

        return is_x_iter and fn(x) or is_x_fn and function(iter_ext)
            return fn(x(iter_ext))
        end
    end,
}

is_iter = function(val)
    return getmetatable(val) == iter_mt
end

as_iter = function(next, data, state)
    nd_assert(is_fn(next), 'next must be of type function')

    return setmetatable({ next, data, state }, iter_mt)
end

empty_next = function()
end

range_v_next = function(data, state)
    local stop = data[1]
    local step = data[2]
    local sign = data[3]

    local val = state + step

    if sign * val < sign * stop then
        return val
    end
end

range_iv_next = function(data, state)
    local len   = data[1]
    local step  = data[2]

    local index = state[1]
    local val   = state[2] + step

    if index < len then
        return { index + 1, val }
    end
end

iv_next = function(data, state)
    local index = state[1] + 1
    local val   = data[index]

    if val then
        return { index, val }
    end
end

kv_next = function(data, state)
    local key, val = next_fn(data, state[1])

    if key then
        return { key, val }
    end
end

keys_next = function(data, state)
    return (next_fn(data, state))
end

mapi_fn = function(i)
    nd_assert(is_num(i), 'i must be of type number')

    return function(elem)
        return elem[i]
    end
end

mapk_fn = function(k)
    return function(elem)
        return elem[k]
    end
end

self = function(val)
    return val
end

empty = function()
    return as_iter(empty_next)
end

range_v = function(len, start, step)
    if not start then start = 1 end
    if not step then step = 1 end

    nd_assert(is_num(len), 'len must be of type number')
    nd_assert(is_num(start), 'start must be of type number')
    nd_assert(is_num(step), 'step must be of type number')
    nd_assert(step ~= 0, 'step must be non-zero')
    nd_assert(len >= 0, 'len must be non-negative')

    local sign = step > 0 and 1 or -1
    local stop = start + step * len

    return as_iter(range_v_next, { stop, step, sign }, start - step)
end

range_iv = function(len, start, step)
    if not start then start = 1 end
    if not step then step = 1 end

    nd_assert(is_num(len), 'len must be of type number')
    nd_assert(is_num(start), 'start must be of type number')
    nd_assert(is_num(step), 'step must be of type number')
    nd_assert(step ~= 0, 'step must be non-zero')
    nd_assert(len >= 0, 'len must be non-negative')

    return as_iter(range_iv_next, { len, step }, { 0, start - step })
end

it = function(fn)
    nd_assert(is_fn(fn), 'fn must be of type function')

    return as_iter(fn)
end

iv = function(t)
    nd_assert(is_tab(t), 't must be of type table')

    return as_iter(iv_next, t, { 0 })
end

kv = function(t)
    nd_assert(is_tab(t), 't must be of type table')

    return as_iter(kv_next, t, {})
end

keys = function(t)
    nd_assert(is_tab(t), 't must be of type table')

    return as_iter(keys_next, t, nil)
end

ivals = function(t)
    nd_assert(is_tab(t), 't must be of type table')

    local index = 0

    return as_iter(function(data, _)
        index = index + 1

        local v = data[index]

        if v then
            return v
        end
    end, t, nil)
end

kvals = function(t)
    nd_assert(is_tab(t), 't must be of type table')

    local key = nil

    return as_iter(function(data, _)
        local k, v = next_fn(data, key)

        key = k

        if v then
            return v
        end
    end, t, nil)
end

mapi = function(i, iter)
    nd_assert(is_num(i), 'i must be of type number')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    return map(mapi_fn(i), iter)
end

mapk = function(k, iter)
    nd_assert(k, 'k must be of type value')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    return map(mapk_fn(k), iter)
end

map = function(fn, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local next = iter[1]
    local data = iter[2]
    local elem = iter[3]

    return as_iter(function(_, _)
        elem = next(data, elem)

        return elem and fn(elem)
    end, data, elem)
end

filter = function(fn, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local next = iter[1]
    local data = iter[2]
    local elem = iter[3]

    return as_iter(function(_, _)
        elem = next(data, elem)

        while elem and not fn(elem) do
            elem = next(data, elem)
        end

        return elem
    end, data, elem)
end

reduce = function(fn, init, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local val = init

    for elem in iter() do
        val = fn(val, elem)
    end

    return val
end

concat = function(iter_, iter)
    nd_assert(is_iter(iter), 'iter must be of type iterator')
    nd_assert(is_iter(iter_), 'iter_ must be of type iterator')

    local next  = iter[1]
    local data  = iter[2]
    local elem  = next(data, iter[3])

    local next_ = iter_[1]
    local data_ = iter_[2]
    local elem_ = next_(data_, iter_[3])

    return as_iter(function(_, _)
        if elem then
            local ret = elem

            elem = next(data, elem)

            return ret
        end

        if elem_ then
            local ret_ = elem_

            elem_ = next_(data_, elem_)

            return ret_
        end
    end, data, elem)
end

zip = function(iter_, iter)
    nd_assert(is_iter(iter), 'iter must be of type iterator')
    nd_assert(is_iter(iter_), 'iter_ must be of type iterator')

    local next  = iter[1]
    local data  = iter[2]
    local elem  = iter[3]

    local next_ = iter_[1]
    local data_ = iter_[2]
    local elem_ = iter_[3]

    return as_iter(function(_, _)
        elem  = next(data, elem)
        elem_ = next_(data_, elem_)

        return elem and elem_ and { elem, elem_ }
    end, data, elem)
end

take = function(n, iter)
    nd_assert(n >= 0, 'n must not be non-negative')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local next  = iter[1]
    local data  = iter[2]
    local elem  = iter[3]
    local index = 0

    return as_iter(function(_, _)
        if index < n then
            elem  = next(data, elem)
            index = index + 1

            return elem
        end
    end, data, elem)
end

skip = function(n, iter)
    nd_assert(n >= 0, 'n must not be non-negative')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local next = iter[1]
    local data = iter[2]
    local elem = iter[3]

    return as_iter(function(_, _)
        if n > 0 then
            for _ in range_v(n)() do
                elem = next(data, elem)
            end

            n = 0
        end

        elem = next(data, elem)

        return elem
    end, data, elem)
end

distinct = function(fn, iter)
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    fn = fn or self

    local set = {}
    local next = iter[1]
    local data = iter[2]
    local elem = iter[3]

    return as_iter(function(_, _)
        repeat
            elem = fn(next(data, elem))
        until not set[elem]

        if elem then
            set[elem] = true
        end

        return elem
    end, data, elem)
end

group = function(fn, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local res = {}

    for elem in iter() do
        local k = fn(elem)

        if not res[k] then
            res[k] = {}
        end

        local arr = res[k]

        arr[#arr + 1] = elem
    end

    return res
end

count = function(iter)
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local index = 0

    for _ in iter() do
        index = index + 1
    end

    return index
end

all = function(fn, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    for elem in iter() do
        if not fn(elem) then
            return false
        end
    end

    return true
end

any = function(fn, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    for elem in iter() do
        if fn(elem) then
            return true
        end
    end

    return false
end

add = function(val, index, iter)
    nd_assert(index > 0, 'index must be greater than zero')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local next = iter[1]
    local data = iter[2]
    local elem = iter[3]
    local ind  = 0

    return as_iter(function(_, _)
        ind = ind + 1

        if ind == index then
            return val
        end

        elem = next(data, elem)

        return elem
    end, data, elem)
end

remove = function(index, iter)
    nd_assert(index > 0, 'index must be greater than zero')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local next = iter[1]
    local data = iter[2]
    local elem = iter[3]
    local ind  = 0

    return as_iter(function(_, _)
        ind = ind + 1

        if ind == index then
            elem = next(data, elem)
        end

        elem = next(data, elem)

        return elem
    end, data, elem)
end

collect = function(iter)
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    local arr = {}
    local index = 0

    for x in iter() do
        index = index + 1

        arr[index] = x
    end

    return arr
end

each = function(fn, iter)
    nd_assert(is_fn(fn), 'fn must be of type function')
    nd_assert(is_iter(iter), 'iter must be of type iterator')

    for elem in iter() do
        fn(elem)
    end
end

pipe = function(iter, args)
    nd_assert(is_iter(iter), 'iter must be of type iterator')
    nd_assert(is_tab(args), 'args must be of type table')

    return reduce(function(val, fn)
        return fn(val)
    end, iter, ivals(args))
end

return {
    is_iter  = is_iter,
    as_iter  = as_iter,
    empty    = empty,
    range_v  = range_v,
    range_iv = range_iv,
    it       = it,
    iv       = iv,
    kv       = kv,
    keys     = keys,
    ivals    = ivals,
    kvals    = kvals,
    mapi     = mapi,
    mapk     = mapk,
    map      = map,
    filter   = filter,
    reduce   = reduce,
    concat   = concat,
    zip      = zip,
    take     = take,
    skip     = skip,
    distinct = distinct,
    group    = group,
    count    = count,
    all      = all,
    any      = any,
    add      = add,
    remove   = remove,
    collect  = collect,
    each     = each,
    pipe     = pipe,
}

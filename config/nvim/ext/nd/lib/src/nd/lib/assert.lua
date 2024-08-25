local assert_fn       = nil
local assert_fn_empty = nil
local get_fn          = nil


assert_fn = function(val, args)
    if not val then
        error(args)
    end

    return val
end

assert_fn_empty = function(val, _)
    return val
end

get_fn = function(is_debug)
    return is_debug and assert_fn or assert_fn_empty
end

return {
    get_fn = get_fn,
}

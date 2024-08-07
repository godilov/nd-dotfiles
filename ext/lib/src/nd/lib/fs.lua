local type_lib      = require 'nd.lib.type'
local assert_lib    = require 'nd.lib.assert'
local serialize_lib = require 'nd.lib.serialize'

local is_val        = type_lib.is_val
local is_str        = type_lib.is_str
local is_tab        = type_lib.is_tab

local nd_assert     = assert_lib.get_fn(ND_LIB_IS_DEBUG)

local as_str        = serialize_lib.as_str
local as_val        = serialize_lib.as_val

local execute       = os.execute

local open          = io.open
local close         = io.close
local popen         = io.popen

local format        = string.format
local gmatch        = string.gmatch
local match         = string.match
local find          = string.find
local sub           = string.sub


local split      = nil
local exists     = nil
local create     = nil
local enum       = nil
local read_file  = nil
local write_file = nil
local read_val   = nil
local write_val  = nil


split = function(path)
    nd_assert(is_str(path), 'path must be of type string')

    local index = find(path, '/?[^/]*$')

    return sub(path, 1, index), sub(path, index + 1, -1)
end

exists = function(path)
    nd_assert(is_str(path), 'path must be of type string')

    local f = open(path, 'rb')

    if f then
        close(f)
    end

    return is_val(f)
end

create = function(path)
    nd_assert(is_str(path), 'path must be of type string')

    nd_assert(execute(format('mkdir -p %s', split(path))), 'mkdir -p failed')

    if match(path, '[^/]$') then
        nd_assert(execute(format('echo "" > %s', path)), 'echo failed')
    end
end

enum = function(path, filter)
    nd_assert(is_str(path) or not path, 'path must be of type string or nil')

    local grep = filter and format('| grep %s', filter)

    local f = nd_assert(popen(format('ls -F %s %s', path or '', grep or '')), 'popen returned nil')

    local arr = {}
    local index = 0

    for s in gmatch(f:read '*a', '[^%s]+') do
        index = index + 1

        arr[index] = s
    end

    close(f)

    return arr
end

read_file = function(path)
    nd_assert(is_str(path), 'path must be of type string')

    local f = nd_assert(open(path), 'io.open returned nil')

    local str = f:read '*a'

    close(f)

    return str
end

write_file = function(path, args)
    nd_assert(is_str(path), 'path must be of type string')
    nd_assert(is_str(args) or is_tab(args), 'args must be of type string or table')

    create(path)

    local f = nd_assert(open(path, 'w'), 'io.open returned nil')

    if is_str(args) then
        f:write(args)
    else
        f:write(unpack(args))
    end

    close(f)
end

read_val = function(path)
    nd_assert(is_str(path), 'path must be of type string')

    return as_val(read_file(path))
end

write_val = function(path, val)
    nd_assert(is_str(path), 'path must be of type string')

    write_file(path, format('return %s', as_str(val) or 'nil'))
end

return {
    split     = split,
    exists    = exists,
    create    = create,
    enum      = enum,
    read      = read_file,
    write     = write_file,
    read_val  = read_val,
    write_val = write_val,
}

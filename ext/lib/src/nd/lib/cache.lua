local fs_lib     = require 'nd.lib.fs'
local str_lib    = require 'nd.lib.str'
local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local exists     = fs_lib.exists
local read_val   = fs_lib.read_val
local write_val  = fs_lib.write_val

local concat2s   = str_lib.concat2s

local is_str     = type_lib.is_str

local nd_assert  = assert_lib.get_fn(ND_LIB_IS_DEBUG)

local match      = string.match

local dir        = './cache/'
local set_dir    = nil
local get_path   = nil

local cache      = {}

local set_fs     = nil
local get_fs     = nil
local set_mem    = nil
local get_mem    = nil


set_dir = function(path)
    nd_assert(is_str(path), 'path must be of type string')

    dir = path

    if not match(dir, '[^/]$') then
        dir = concat2s(dir, '/')
    end
end

get_path = function(key)
    nd_assert(is_str(key), 'key must be of type string')

    return concat2s(dir, key)
end

set_fs = function(key, val)
    write_val(get_path(key), val)
end

get_fs = function(key)
    local path = get_path(key)

    return exists(path) and read_val(path)
end

set_mem = function(key, val)
    cache[key] = val
end

get_mem = function(key)
    return cache[key]
end

return {
    fs = {
        set_dir = set_dir,
        set     = set_fs,
        get     = get_fs,
    },
    mem = {
        set = set_mem,
        get = get_mem,
    },
}

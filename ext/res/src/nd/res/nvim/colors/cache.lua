local type_lib     = require 'nd.lib.type'
local assert_lib   = require 'nd.lib.assert'

local nvim_fn      = require 'nd.res.colors.nvim'
local colors_cache = require 'nd.res.colors_cache'

local is_str       = type_lib.is_str
local is_tab       = type_lib.is_tab

local nd_assert    = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err       = assert_lib.get_err_fn 'nd.res.nvim.colors.cache'

local get_keyname  = colors_cache.get_keyname
local get_scheme   = colors_cache.get_scheme


local get = nil


get = function(config, is_forced)
    nd_assert(is_tab(config), nd_err, 'get(): config must be of type table')

    local palette     = config.palette
    local accent      = config.accent
    local highlight   = config.highlight
    local scheme_n    = config.scheme
    local palette_n   = is_str(palette) and palette or config.palette_name or scheme_n
    local accent_n    = is_str(accent) and accent or config.accent_name or scheme_n
    local highlight_n = is_str(highlight) and highlight or config.highlight_name or scheme_n

    nd_assert(is_str(scheme_n) or not scheme_n, nd_err, 'get(): scheme must be of type string or nil')

    nd_assert(is_str(palette_n), nd_err, 'get(): palette or palette_name or scheme must be of type string')
    nd_assert(is_str(accent_n), nd_err, 'get(): accent or accent_name or scheme must be of type string')
    nd_assert(is_str(highlight_n), nd_err, 'get(): highlight or highlight_name or scheme must be of type string')

    local key = get_keyname { 'nvim', palette_n, accent_n, highlight_n }

    return get_scheme(nvim_fn, config, key, is_forced)
end

return {
    get = get,
}

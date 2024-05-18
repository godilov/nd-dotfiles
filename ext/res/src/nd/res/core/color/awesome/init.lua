local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local load_fn    = require 'nd.res.core.load'

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.awesome'

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')
    nd_assert(is_str(config.scheme) or not config.scheme, nd_err, 'fn(): scheme must be of type string or nil')

    local palette_cfg = config.palette or config.scheme
    local accent_cfg  = config.accent or config.scheme
    local theme_cfg   = config.theme or config.scheme

    nd_assert(palette_cfg, nd_err, 'fn(): palette must be of type value')
    nd_assert(accent_cfg, nd_err, 'fn(): accent must be of type value')
    nd_assert(theme_cfg, nd_err, 'fn(): theme must be of type value')

    local palette = load_fn('nd.res.core.color.palette', palette_cfg, {})
    local accent  = load_fn('nd.res.core.color.awesome.accent', accent_cfg, { palette = palette })
    local theme   = load_fn('nd.res.core.color.awesome.theme', theme_cfg, { palette = palette, accent = accent })

    return {
        palette = palette,
        accent  = accent,
        theme   = theme,
    }
end

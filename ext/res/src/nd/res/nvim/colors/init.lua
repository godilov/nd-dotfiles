local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local load_fn    = require 'nd.res.load'

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.nvim.colors'

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')
    nd_assert(is_str(config.scheme) or not config.scheme, nd_err, 'fn(): scheme must be of type string or nil')

    local palette_cfg   = config.palette or config.scheme
    local accent_cfg    = config.accent or config.scheme
    local highlight_cfg = config.highlight or config.scheme
    local special_cfg   = config.special or config.scheme

    nd_assert(palette_cfg, nd_err, 'fn(): palette must be of type value')
    nd_assert(accent_cfg, nd_err, 'fn(): accent must be of type value')
    nd_assert(highlight_cfg, nd_err, 'fn(): highlight must be of type value')

    local palette   = load_fn('nd.res.palettes', palette_cfg, {})
    local accent    = load_fn('nd.res.nvim.colors.accents', accent_cfg, { palette = palette })
    local highlight = load_fn('nd.res.nvim.colors.highlights', highlight_cfg, {
        palette = palette,
        accent  = accent,
    })

    local special   = special_cfg and load_fn('nd.res.nvim.colors.specials', special_cfg, {
        palette   = palette,
        accent    = accent,
        highlight = highlight,
    })

    return {
        palette   = palette,
        accent    = accent,
        highlight = highlight,
        special   = special,
    }
end

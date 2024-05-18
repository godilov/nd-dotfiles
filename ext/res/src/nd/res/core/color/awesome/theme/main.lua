local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.awesome.theme.main'

return function(config)
    local palette = config.palette
    local accent = config.accent

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(accent), nd_err, 'fn(): accent must be of type table')

    return {
        raw = {
            font          = 'Fira Code Bold 8.5',
            wallpaper     = '/usr/share/backgrounds/wallpapers/Colors/Black/sand.png',
            bg_normal     = accent.core.dark,
            bg_systray    = accent.core.dark,
            bg_minimize   = accent.core.light,
            bg_focus      = accent.core.light,
            bg_urgent     = accent.emphasis.dark,
            fg_normal     = accent.text.dark,
            fg_focus      = accent.text.light,
            fg_urgent     = accent.text.light,
            fg_minimize   = accent.text.dark,
            border_normal = nil,
            border_focus  = nil,
            border_marked = nil,
            border_color  = nil,
            useless_gap   = nil,
        },
    }
end

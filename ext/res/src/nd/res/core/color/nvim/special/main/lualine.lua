local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'
local color_lib  = require 'nd.lib.core.color'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.special.main.lualine'

local as_hex     = color_lib.rgb.as_hex
local from_hex   = color_lib.rgb.from_hex


local abc_fn = nil

abc_fn = function(color_rgb, bg_rgb, _, bg, fg)
    return {
        a = { fg = bg, bg = as_hex(1.0 * color_rgb + 0.0 * bg_rgb), gui = 'bold' },
        b = { fg = fg, bg = as_hex(0.5 * color_rgb + 0.5 * bg_rgb) },
        c = { fg = fg, bg = nil },
    }
end

return function(scheme)
    nd_assert(is_tab(scheme), nd_err, 'fn(): scheme must be of type table')

    local palette = scheme.palette
    local accent  = scheme.accent

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(accent), nd_err, 'fn(): accent must be of type table')

    local bg = palette.bg.normal
    local fg = palette.fg.normal

    local bg_rgb = from_hex(bg)
    local fg_rgb = from_hex(fg)

    return {
        normal   = abc_fn(from_hex(palette.yellow.normal), bg_rgb, fg_rgb, bg, fg),
        insert   = abc_fn(from_hex(palette.red.normal), bg_rgb, fg_rgb, bg, fg),
        visual   = abc_fn(from_hex(palette.green.normal), bg_rgb, fg_rgb, bg, fg),
        replace  = abc_fn(from_hex(palette.blue.normal), bg_rgb, fg_rgb, bg, fg),
        command  = abc_fn(from_hex(palette.magenta.normal), bg_rgb, fg_rgb, bg, fg),
        inactive = abc_fn(bg_rgb, bg_rgb, fg_rgb, bg, fg),
    }
end

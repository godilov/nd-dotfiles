local color_lib = require 'nd.lib.color'

local val = {
    { 1.0, 0.75 },
    { 1.0, 0.80 },
    { 1.0, 0.85 },
}

local hsl = nil


hsl = function(x)
    local hsl_fn = color_lib.hsl.from
    local hex_fn = color_lib.hsl.as_hex

    return hex_fn(hsl_fn(x))
end


return function(_)
    return {
        fg = {
            normal = hsl { 0, 0, 1.00, 0 },
        },
        bg = {
            normal = hsl { 0, 0, 0.00, 0 },
        },
        black = {
            dark   = hsl { 0, 0, 0.05, 0 },
            normal = hsl { 0, 0, 0.10, 0 },
            light  = hsl { 0, 0, 0.15, 0 },
        },
        red = {
            dark   = hsl { 0, val[1][1], val[1][2], 0 },
            normal = hsl { 0, val[2][1], val[2][2], 0 },
            light  = hsl { 0, val[3][1], val[3][2], 0 },
        },
        yellow = {
            dark   = hsl { 30, val[1][1], val[1][2], 0 },
            normal = hsl { 30, val[2][1], val[2][2], 0 },
            light  = hsl { 30, val[3][1], val[3][2], 0 },
        },
        green = {
            dark   = hsl { 60, val[1][1], val[1][2], 0 },
            normal = hsl { 60, val[2][1], val[2][2], 0 },
            light  = hsl { 60, val[3][1], val[3][2], 0 },
        },
        blue = {
            dark   = hsl { 210, val[1][1], val[1][2], 0 },
            normal = hsl { 210, val[2][1], val[2][2], 0 },
            light  = hsl { 210, val[3][1], val[3][2], 0 },
        },
        magenta = {
            dark   = hsl { 330, val[1][1], val[1][2], 0 },
            normal = hsl { 330, val[2][1], val[2][2], 0 },
            light  = hsl { 330, val[3][1], val[3][2], 0 },
        },
        cyan = {
            dark   = hsl { 180, val[1][1], val[1][2], 0 },
            normal = hsl { 180, val[2][1], val[2][2], 0 },
            light  = hsl { 180, val[3][1], val[3][2], 0 },
        },
        white = {
            dark   = hsl { 0, 0, 0.85, 0 },
            normal = hsl { 0, 0, 0.90, 0 },
            light  = hsl { 0, 0, 0.95, 0 },
        },
    }
end

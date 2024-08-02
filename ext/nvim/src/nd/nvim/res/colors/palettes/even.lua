local color_lib = require 'nd.lib.color'

local hsb = color_lib.hsb.from
local hex = color_lib.hsb.as_hex

local hsb_val = {
    { 0.7, 0.9 },
    { 0.6, 1.0 },
    { 0.4, 1.0 },
}

local fn = nil


fn = function(val)
    return hex(hsb(val))
end


return function(_)
    return {
        fg = {
            normal = fn { 0, 0, 1.00, 0 },
        },
        bg = {
            normal = fn { 0, 0, 0.00, 0 },
        },
        black = {
            dark   = fn { 0, 0, 0.05, 0 },
            normal = fn { 0, 0, 0.10, 0 },
            light  = fn { 0, 0, 0.15, 0 },
        },
        red = {
            dark   = fn { 0, hsb_val[1][1], hsb_val[1][2], 0 },
            normal = fn { 0, hsb_val[2][1], hsb_val[2][2], 0 },
            light  = fn { 0, hsb_val[3][1], hsb_val[3][2], 0 },
        },
        yellow = {
            dark   = fn { 30, hsb_val[1][1], hsb_val[1][2], 0 },
            normal = fn { 30, hsb_val[2][1], hsb_val[2][2], 0 },
            light  = fn { 30, hsb_val[3][1], hsb_val[3][2], 0 },
        },
        green = {
            dark   = fn { 60, hsb_val[1][1], hsb_val[1][2], 0 },
            normal = fn { 60, hsb_val[2][1], hsb_val[2][2], 0 },
            light  = fn { 60, hsb_val[3][1], hsb_val[3][2], 0 },
        },
        blue = {
            dark   = fn { 210, hsb_val[1][1], hsb_val[1][2], 0 },
            normal = fn { 210, hsb_val[2][1], hsb_val[2][2], 0 },
            light  = fn { 210, hsb_val[3][1], hsb_val[3][2], 0 },
        },
        magenta = {
            dark   = fn { 330, hsb_val[1][1], hsb_val[1][2], 0 },
            normal = fn { 330, hsb_val[2][1], hsb_val[2][2], 0 },
            light  = fn { 330, hsb_val[3][1], hsb_val[3][2], 0 },
        },
        cyan = {
            dark   = fn { 180, hsb_val[1][1], hsb_val[1][2], 0 },
            normal = fn { 180, hsb_val[2][1], hsb_val[2][2], 0 },
            light  = fn { 180, hsb_val[3][1], hsb_val[3][2], 0 },
        },
        white = {
            dark   = fn { 0, 0, 0.85, 0 },
            normal = fn { 0, 0, 0.90, 0 },
            light  = fn { 0, 0, 0.95, 0 },
        },
    }
end

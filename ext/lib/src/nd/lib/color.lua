local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'
local math_lib   = require 'nd.lib.math'

local is_bool    = type_lib.is_bool
local is_num     = type_lib.is_num
local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_LIB_IS_DEBUG)

local clamp      = math_lib.clamp

local format     = string.format
local substr     = string.sub
local lenstr     = string.len

local abs        = math.abs
local min        = math.min
local max        = math.max

local tonumber   = tonumber


local bit = require 'bit'
local ffi = require 'ffi'

ffi.cdef [[
    typedef int8_t  i8;
    typedef int16_t i16;
    typedef int32_t i32;
    typedef int64_t i64;

    typedef uint8_t  u8;
    typedef uint16_t u16;
    typedef uint32_t u32;
    typedef uint64_t u64;

    typedef float  f32;
    typedef double f64;

    typedef struct rgb {
        u8 data[4];
    } rgb_t;

    typedef struct hsl {
        f32 data[4];
    } hsl_t;

    typedef struct hsb {
        f32 data[4];
    } hsb_t;
]]

local rshift = bit.rshift
local band   = bit.band


local xy_fn        = nil

local add          = nil
local sub          = nil
local mul          = nil
local div          = nil

local rgb_hue      = nil
local hsl_comp     = nil
local hsb_comp     = nil

local rgb_as_hsl   = nil
local rgb_as_hsb   = nil
local hsl_as_rgb   = nil
local hsb_as_rgb   = nil

local rgb_as_hex   = nil
local hsl_as_hex   = nil
local hsb_as_hex   = nil

local rgb_from_hex = nil
local hsl_from_hex = nil
local hsb_from_hex = nil

local rgb_from     = nil
local hsl_from     = nil
local hsb_from     = nil

local rgb_add      = nil
local rgb_sub      = nil
local rgb_mul      = nil
local rgb_div      = nil

local hsl_add      = nil
local hsl_sub      = nil
local hsl_mul      = nil
local hsl_div      = nil

local hsb_add      = nil
local hsb_sub      = nil
local hsb_mul      = nil
local hsb_div      = nil

local rgb_mt       = nil
local hsl_mt       = nil
local hsb_mt       = nil

local rgb_t        = rgb_t
local hsl_t        = hsl_t
local hsb_t        = hsb_t

local is_rgb       = nil
local is_hsl       = nil
local is_hsb       = nil
local is_color     = nil






xy_fn = function(x, y)
    if is_color(x) then
        return x, y
    else
        return y, x
    end
end

add = function(fn)
    return function(x, y)
        local x_, y_     = xy_fn(x, y)

        local is_y_num   = is_num(y_)
        local is_y_tab   = is_tab(y_)
        local is_y_color = is_color(y_)

        nd_assert(is_color(x_), 'x must be of type color')
        nd_assert(is_y_num or is_y_tab or is_y_color, 'y must be of type number, table or number')

        return fn {
            x_.data[0] + (is_y_num and y_ or is_y_tab and y_[1] or y_.data[0]),
            x_.data[1] + (is_y_num and y_ or is_y_tab and y_[2] or y_.data[1]),
            x_.data[2] + (is_y_num and y_ or is_y_tab and y_[3] or y_.data[2]),
            x_.data[3] + (is_y_num and y_ or is_y_tab and y_[4] or y_.data[3]),
        }
    end
end

sub = function(fn)
    return function(x, y)
        local x_, y_     = xy_fn(x, y)

        local is_y_num   = is_num(y_)
        local is_y_tab   = is_tab(y_)
        local is_y_color = is_color(y_)

        nd_assert(is_color(x_), 'x must be of type color')
        nd_assert(is_y_num or is_y_tab or is_y_color, 'y must be of type number, table or number')

        return fn {
            x_.data[0] - (is_y_num and y_ or is_y_tab and y_[1] or y_.data[0]),
            x_.data[1] - (is_y_num and y_ or is_y_tab and y_[2] or y_.data[1]),
            x_.data[2] - (is_y_num and y_ or is_y_tab and y_[3] or y_.data[2]),
            x_.data[3] - (is_y_num and y_ or is_y_tab and y_[4] or y_.data[3]),
        }
    end
end

mul = function(fn)
    return function(x, y)
        local x_, y_     = xy_fn(x, y)

        local is_y_num   = is_num(y_)
        local is_y_tab   = is_tab(y_)
        local is_y_color = is_color(y_)

        nd_assert(is_color(x_), 'x must be of type color')
        nd_assert(is_y_num or is_y_tab or is_y_color, 'y must be of type number, table or number')

        return fn {
            x_.data[0] * (is_y_num and y_ or is_y_tab and y_[1] or y_.data[0]),
            x_.data[1] * (is_y_num and y_ or is_y_tab and y_[2] or y_.data[1]),
            x_.data[2] * (is_y_num and y_ or is_y_tab and y_[3] or y_.data[2]),
            x_.data[3] * (is_y_num and y_ or is_y_tab and y_[4] or y_.data[3]),
        }
    end
end

div = function(fn)
    return function(x, y)
        local x_, y_     = xy_fn(x, y)

        local is_y_num   = is_num(y_)
        local is_y_tab   = is_tab(y_)
        local is_y_color = is_color(y_)

        nd_assert(is_color(x_), 'x must be of type color')
        nd_assert(is_y_num or is_y_tab or is_y_color, 'y must be of type number, table or number')

        return fn {
            x_.data[0] / (is_y_num and y_ or is_y_tab and y_[1] or y_.data[0]),
            x_.data[1] / (is_y_num and y_ or is_y_tab and y_[2] or y_.data[1]),
            x_.data[2] / (is_y_num and y_ or is_y_tab and y_[3] or y_.data[2]),
            x_.data[3] / (is_y_num and y_ or is_y_tab and y_[4] or y_.data[3]),
        }
    end
end

rgb_hue = function(color)
    nd_assert(is_rgb(color), 'color must be of type rgb')

    local r = color.data[0] / 255
    local g = color.data[1] / 255
    local b = color.data[2] / 255

    local min_val = min(r, g, b)
    local max_val = max(r, g, b)

    if min_val == max_val then
        return 0
    end

    local len = max_val - min_val

    if r == max_val then
        return (60 * (0 + (g - b) / len)) % 360
    elseif g == max_val then
        return (60 * (2 + (b - r) / len)) % 360
    elseif b == max_val then
        return (60 * (4 + (r - g) / len)) % 360
    end

    return 0
end

hsl_comp = function(color, n)
    nd_assert(is_hsl(color), 'color must be of type hsl')

    local h = color.data[0]
    local s = color.data[1]
    local l = color.data[2]

    local k = (n + h / 30) % 12

    return l - s * min(l, 1 - l) * max(min(k - 3, 9 - k, 1), -1)
end

hsb_comp = function(color, n)
    nd_assert(is_hsb(color), 'color must be of type hsb')

    local h = color.data[0]
    local s = color.data[1]
    local b = color.data[2]

    local k = (n + h / 60) % 6

    return b * (1 - s * max(min(k, 4 - k, 1), 0))
end

rgb_as_hsl = function(color)
    nd_assert(is_rgb(color), 'color must be of type rgb')

    local r_ = color.data[0] / 255
    local g_ = color.data[1] / 255
    local b_ = color.data[2] / 255
    local a = color.data[3] / 255

    local min_val = min(r_, g_, b_)
    local max_val = max(r_, g_, b_)

    local len = max_val - min_val

    local h = rgb_hue(color)
    local l = (max_val + min_val) / 2
    local s = len / (1 - abs(2 * l - 1))

    return hsl_t { { h, s, l, a } }
end

rgb_as_hsb = function(color)
    nd_assert(is_rgb(color), 'color must be of type rgb')

    local r_ = color.data[0] / 255
    local g_ = color.data[1] / 255
    local b_ = color.data[2] / 255
    local a = color.data[3] / 255

    local min_val = min(r_, g_, b_)
    local max_val = max(r_, g_, b_)

    local len = max_val - min_val

    local h = rgb_hue(color)
    local b = max_val
    local s = b and len / b or 0

    return hsb_t { { h, s, b, a } }
end

hsl_as_rgb = function(color)
    nd_assert(is_hsl(color), 'color must be of type hsl')

    return rgb_t { {
        255 * hsl_comp(color, 0),
        255 * hsl_comp(color, 8),
        255 * hsl_comp(color, 4),
        255 * color.data[3],
    } }
end

hsb_as_rgb = function(color)
    nd_assert(is_hsb(color), 'color must be of type hsb')

    return rgb_t { {
        255 * hsb_comp(color, 5),
        255 * hsb_comp(color, 3),
        255 * hsb_comp(color, 1),
        255 * color.data[3],
    } }
end

rgb_as_hex = function(color, alpha)
    nd_assert(is_rgb(color), 'color must be of type rgb')

    local alpha_val = is_bool(alpha) and color.data[3] or is_num(alpha) and clamp(alpha, 0, 255) or nil

    local r = color.data[0]
    local g = color.data[1]
    local b = color.data[2]
    local a = alpha_val and format('%.2X', alpha_val) or ''

    return format('#%s%.2X%.2X%.2X', a, r, g, b)
end

hsl_as_hex = function(color, alpha)
    nd_assert(is_hsl(color), 'color must be of type hsl')

    return rgb_as_hex(hsl_as_rgb(color), alpha)
end

hsb_as_hex = function(color, alpha)
    nd_assert(is_hsb(color), 'color must be of type hsb')

    return rgb_as_hex(hsb_as_rgb(color), alpha)
end

rgb_from_hex = function(hex)
    local len = lenstr(hex)

    nd_assert(is_str(hex), 'hex must be of type string')
    nd_assert(len >= 6, 'hex must be at least of len 6')

    local n = tonumber(substr(hex, len >= 8 and -8 or -6), 16)

    local a = rshift(band(n, 0xFF000000), 24)
    local r = rshift(band(n, 0x00FF0000), 16)
    local g = rshift(band(n, 0x0000FF00), 8)
    local b = rshift(band(n, 0x000000FF), 0)

    return rgb_t { { r, g, b, a } }
end

hsl_from_hex = function(hex)
    nd_assert(is_str(hex), 'hex must be of type string')

    return rgb_as_hsl(rgb_from_hex(hex))
end

hsb_from_hex = function(hex)
    nd_assert(is_str(hex), 'hex must be of type string')

    return rgb_as_hsb(rgb_from_hex(hex))
end

rgb_from = function(val)
    local is_val_tab = is_tab(val)
    local is_val_num = is_num(val)

    nd_assert(is_val_tab or is_val_num, 'val must be of type table or number')


    return rgb_t { {
        clamp(is_val_tab and val[1] or val, 0, 255),
        clamp(is_val_tab and val[2] or val, 0, 255),
        clamp(is_val_tab and val[3] or val, 0, 255),
        clamp(is_val_tab and val[4] or val, 0, 255),
    } }
end

hsl_from = function(val)
    local is_val_tab = is_tab(val)
    local is_val_num = is_num(val)

    nd_assert(is_val_tab or is_val_num, 'val must be of type table or number')


    return hsl_t { {
        clamp(is_val_tab and val[1] or val, 0, 360),
        clamp(is_val_tab and val[2] or val, 0.0, 1.0),
        clamp(is_val_tab and val[3] or val, 0.0, 1.0),
        clamp(is_val_tab and val[4] or val, 0.0, 1.0),
    } }
end

hsb_from = function(val)
    local is_val_tab = is_tab(val)
    local is_val_num = is_num(val)

    nd_assert(is_val_tab or is_val_num, 'val must be of type table or number')


    return hsb_t { {
        clamp(is_val_tab and val[1] or val, 0, 360),
        clamp(is_val_tab and val[2] or val, 0.0, 1.0),
        clamp(is_val_tab and val[3] or val, 0.0, 1.0),
        clamp(is_val_tab and val[4] or val, 0.0, 1.0),
    } }
end

rgb_add = add(rgb_from)
rgb_sub = sub(rgb_from)
rgb_mul = mul(rgb_from)
rgb_div = div(rgb_from)

hsl_add = add(hsl_from)
hsl_sub = sub(hsl_from)
hsl_mul = mul(hsl_from)
hsl_div = div(hsl_from)

hsb_add = add(hsb_from)
hsb_sub = sub(hsb_from)
hsb_mul = mul(hsb_from)
hsb_div = div(hsb_from)

rgb_mt = {
    __add = rgb_add,
    __sub = rgb_sub,
    __mul = rgb_mul,
    __div = rgb_div,
}

hsl_mt = {
    __add = hsl_add,
    __sub = hsl_sub,
    __mul = hsl_mul,
    __div = hsl_div,
}

hsb_mt = {
    __add = hsb_add,
    __sub = hsb_sub,
    __mul = hsb_mul,
    __div = hsb_div,
}

rgb_t = ffi.metatype('rgb_t', rgb_mt)
hsl_t = ffi.metatype('hsl_t', hsl_mt)
hsb_t = ffi.metatype('hsb_t', hsb_mt)


is_rgb = function(val)
    return ffi.istype(rgb_t, val)
end

is_hsl = function(val)
    return ffi.istype(hsl_t, val)
end

is_hsb = function(val)
    return ffi.istype(hsb_t, val)
end

is_color = function(val)
    return is_rgb(val) or is_hsl(val) or is_hsb(val)
end

return {
    rgb = {
        add      = rgb_add,
        sub      = rgb_sub,
        mul      = rgb_mul,
        div      = rgb_div,
        hue      = rgb_hue,
        as_hsl   = rgb_as_hsl,
        as_hsb   = rgb_as_hsb,
        as_hex   = rgb_as_hex,
        from_hex = rgb_from_hex,
        from     = rgb_from,
        type     = rgb_t,
    },
    hsl = {
        add      = hsl_add,
        sub      = hsl_sub,
        mul      = hsl_mul,
        div      = hsl_div,
        comp     = hsl_comp,
        as_rgb   = hsl_as_rgb,
        as_hex   = hsl_as_hex,
        from_rgb = rgb_as_hsl,
        from_hex = hsl_from_hex,
        from     = hsl_from,
        type     = hsl_t,
    },
    hsb = {
        add      = hsb_add,
        sub      = hsb_sub,
        mul      = hsb_mul,
        div      = hsb_div,
        comp     = hsb_comp,
        as_rgb   = hsb_as_rgb,
        as_hex   = hsb_as_hex,
        from_rgb = rgb_as_hsb,
        from_hex = hsb_from_hex,
        from     = hsb_from,
        type     = hsb_t,
    },
    is_rgb = is_rgb,
    is_hsl = is_hsl,
    is_hsb = is_hsb,
    is_color = is_color,
}

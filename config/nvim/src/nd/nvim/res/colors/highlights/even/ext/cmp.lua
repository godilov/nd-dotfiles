local tab_lib    = require 'nd.lib.tab'
local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local concat     = tab_lib.concat

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)


return function(config)
    local palette = config.palette
    local accent  = config.accent

    nd_assert(is_tab(palette), 'palette must be of type table')
    nd_assert(is_tab(accent), 'accent must be of type table')

    local none = 'NONE'

    return {
        { 'CmpItemAbbr',           palette.fg.normal,    none, none, none },
        { 'CmpItemAbbrDeprecated', palette.white.dark,   none, none, 'underline' },
        { 'CmpItemAbbrMatch',      palette.yellow.light, none, none, none },
        { 'CmpItemAbbrMatchFuzzy', palette.red.light,    none, none, none },
        { 'CmpItemKind',           palette.yellow.light, none, none, none },
        { 'CmpItemMenu',           palette.magenta.dark, none, none, none },
    }
end

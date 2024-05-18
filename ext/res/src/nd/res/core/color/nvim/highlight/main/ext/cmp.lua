local tab_lib    = require 'nd.lib.core.tab'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local concat     = tab_lib.concat

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.highlight.main.ext.cmp'

--
-- Group = { hl, fg, bg, sp, gui, link }
--

return function(config)
    local palette = config.palette
    local accent  = config.accent

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(accent), nd_err, 'fn(): accent must be of type table')

    local none = 'NONE'

    return {
        { 'CmpItemAbbr',           palette.fg.normal,      none, none, none },
        { 'CmpItemAbbrDeprecated', palette.white.dark,     none, none, 'underline' },
        { 'CmpItemAbbrMatch',      palette.yellow.light,   none, none, none },
        { 'CmpItemAbbrMatchFuzzy', palette.red.light,      none, none, none },
        { 'CmpItemKind',           palette.yellow.light,   none, none, none },
        { 'CmpItemMenu',           palette.magenta.normal, none, none, none },
    }
end

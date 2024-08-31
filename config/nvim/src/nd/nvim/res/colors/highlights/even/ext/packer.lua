local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)


return function(config)
    local palette = config.palette
    local accent  = config.accent

    nd_assert(is_tab(palette), 'palette must be of type table')
    nd_assert(is_tab(accent), 'accent must be of type table')

    local none = 'NONE'

    return {
        { 'packerPackageName',      palette.fg.normal,    none, none, none },
        { 'packerPackageNotLoaded', palette.white.dark,   none, none, 'underline' },
        { 'packerBool',             palette.green.dark,   none, none, none },
        { 'packerString',           palette.green.dark,   none, none, none },
        { 'packerSuccess',          palette.green.dark,   none, none, none },
        { 'packerFail',             palette.red.dark,     none, none, none },
        { 'packerStatus',           palette.blue.dark,    none, none, none },
        { 'packerStatusSuccess',    palette.green.dark,   none, none, none },
        { 'packerStatusFail',       palette.red.dark,     none, none, none },
        { 'packerStatusCommit',     palette.blue.dark,    none, none, none },
        { 'packerBreakingChange',   palette.yellow.dark,  none, none, 'underline' },
        --
        { 'packerOutput',           palette.yellow.dark,  none, none, none },
        { 'packerHash',             palette.fg.normal,    none, none, none },
        { 'packerRelDate',          palette.yellow.dark,  none, none, none },
        { 'packerWorking',          palette.cyan.dark,    none, none, none },
        { 'packerProgress',         palette.green.dark,   none, none, none },
        --
        { 'packerTimeHigh',         palette.red.light,    none, none, none },
        { 'packerTimeMedium',       palette.yellow.light, none, none, none },
        { 'packerTimeLow',          palette.green.light,  none, none, none },
        { 'packerTimeTrivial',      palette.fg.normal,    none, none, none },
    }
end

local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.highlight.main.ext.packer'

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
        { 'packerPackageName',      palette.fg.normal,     none, none, none },
        { 'packerPackageNotLoaded', palette.white.dark,    none, none, 'underline' },
        { 'packerBool',             palette.green.normal,  none, none, none },
        { 'packerString',           palette.green.normal,  none, none, none },
        { 'packerSuccess',          palette.green.normal,  none, none, none },
        { 'packerFail',             palette.red.normal,    none, none, none },
        { 'packerStatus',           palette.blue.normal,   none, none, none },
        { 'packerStatusSuccess',    palette.green.normal,  none, none, none },
        { 'packerStatusFail',       palette.red.normal,    none, none, none },
        { 'packerStatusCommit',     palette.blue.normal,   none, none, none },
        { 'packerBreakingChange',   palette.yellow.normal, none, none, 'underline' },
        --
        { 'packerOutput',           palette.yellow.normal, none, none, none },
        { 'packerHash',             palette.fg.normal,     none, none, none },
        { 'packerRelDate',          palette.yellow.normal, none, none, none },
        { 'packerWorking',          palette.cyan.normal,   none, none, none },
        { 'packerProgress',         palette.green.normal,  none, none, none },
        --
        { 'packerTimeHigh',         palette.red.light,     none, none, none },
        { 'packerTimeMedium',       palette.yellow.light,  none, none, none },
        { 'packerTimeLow',          palette.green.light,   none, none, none },
        { 'packerTimeTrivial',      palette.fg.normal,     none, none, none },
    }
end

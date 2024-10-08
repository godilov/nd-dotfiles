local tab_lib    = require 'nd.lib.tab'
local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local flat       = tab_lib.flat
local clone_with = tab_lib.clone_with

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)


return function(config)
    local palette = config.palette
    local accent  = config.accent

    nd_assert(is_tab(palette), 'palette must be of type table')
    nd_assert(is_tab(accent), 'accent must be of type table')

    local none = 'NONE'

    return {
        { 'Normal',       palette.fg.normal,   none,              none, none },
        { 'NormalNC',     palette.fg.normal,   none,              none, none },
        { 'StatusLine',   palette.fg.normal,   palette.bg.normal, none, none },
        { 'StatusLineNC', palette.bg.normal,   palette.bg.normal, none, none },
        --
        { 'Cursor',       none,                none,              none, none },
        { 'CursorLine',   palette.bg.normal,   palette.fg.normal, none, none },
        { 'CursorColumn', palette.bg.normal,   palette.fg.normal, none, none },
        { 'TermCursor',   palette.bg.normal,   palette.fg.normal, none, none },
        { 'TermCursorNC', palette.bg.normal,   palette.fg.normal, none, none },
        --
        { 'Error',        palette.red.dark,    none,              none, none },
        { 'ErrorMsg',     palette.red.dark,    none,              none, none },
        { 'WarningMsg',   palette.yellow.dark, none,              none, none },
        { 'MoreMsg',      palette.green.dark,  none,              none, none },
        { 'ModeMsg',      palette.white.light, none,              none, none },
        --
        flat { 'DiagnosticError', accent.diag.error },
        flat { 'DiagnosticWarn', accent.diag.warn },
        flat { 'DiagnosticInfo', accent.diag.info },
        flat { 'DiagnosticHint', accent.diag.hint },
        --
        flat { 'DiagnosticVirtualTextError', accent.diag.error },
        flat { 'DiagnosticVirtualTextWarn', accent.diag.warn },
        flat { 'DiagnosticVirtualTextInfo', accent.diag.info },
        flat { 'DiagnosticVirtualTextHint', accent.diag.hint },
        --
        flat { 'DiagnosticUnderlineError', clone_with(accent.diag.error, { [4] = 'underline' }) },
        flat { 'DiagnosticUnderlineWarn', clone_with(accent.diag.warn, { [4] = 'underline' }) },
        flat { 'DiagnosticUnderlineInfo', clone_with(accent.diag.info, { [4] = 'underline' }) },
        flat { 'DiagnosticUnderlineHint', clone_with(accent.diag.hint, { [4] = 'underline' }) },
        --
        flat { 'DiagnosticFloatingError', accent.diag.error },
        flat { 'DiagnosticFloatingWarn', accent.diag.warn },
        flat { 'DiagnosticFloatingInfo', accent.diag.info },
        flat { 'DiagnosticFloatingHint', accent.diag.hint },
        --
        flat { 'DiagnosticSignError', accent.diag.error },
        flat { 'DiagnosticSignWarn', accent.diag.warn },
        flat { 'DiagnosticSignInfo', accent.diag.info },
        flat { 'DiagnosticSignHint', accent.diag.hint },
        --
        { 'WinSeparator', palette.black.light,  none,                 none, none },
        { 'EndOfBuffer',  palette.yellow.light, none,                 none, none },
        { 'SignColumn',   none,                 none,                 none, none },
        --
        { 'LineNr',       palette.yellow.light, none,                 none, none },
        { 'LineNrAbove',  palette.yellow.light, none,                 none, none },
        { 'LineNrBelow',  palette.yellow.light, none,                 none, none },
        --
        { 'MatchParen',   palette.bg.normal,    palette.yellow.light, none, 'reverse' },
        { 'Substitute',   palette.bg.normal,    palette.yellow.light, none, none },
        { 'CurSearch',    palette.bg.normal,    palette.red.light,    none, none },
        { 'IncSearch',    palette.bg.normal,    palette.red.light,    none, none },
        { 'Search',       palette.bg.normal,    palette.yellow.light, none, none },
        { 'Visual',       palette.bg.normal,    palette.yellow.light, none, none },
        --
        { 'Title',        palette.red.dark,     none,                 none, 'bold' },
        { 'Pmenu',        palette.white.light,  palette.black.dark,   none, none },
        { 'PmenuSel',     palette.black.dark,   palette.yellow.light, none, none },
        { 'PmenuSbar',    none,                 palette.bg.normal,    none, none },
        { 'PmenuThumb',   none,                 palette.yellow.light, none, none },
        --
        { 'Directory',    palette.fg.normal,    none,                 none, none },
        { 'DiffAdd',      palette.green.dark,   none,                 none, none },
        { 'DiffChange',   palette.yellow.dark,  none,                 none, none },
        { 'DiffDelete',   palette.red.dark,     none,                 none, none },
        { 'DiffText',     palette.fg.normal,    none,                 none, none },
    }
end

local tab_lib    = require 'nd.lib.core.tab'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'
local color_lib  = require 'nd.lib.core.color'

local clone_with = tab_lib.clone_with

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.accent.main'

local as_hex     = color_lib.rgb.as_hex
local from_hex   = color_lib.rgb.from_hex

--
-- Group = { fg, bg, sp, gui, link }
--

return function(config)
    local palette = config.palette

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')

    local none = 'NONE'

    local diag = {
        error = { palette.red.normal, none, none, none },
        warn  = { palette.yellow.normal, none, none, none },
        info  = { palette.green.normal, none, none, none },
        hint  = { palette.fg.normal, none, none, none },
    }

    local note = {
        error = clone_with(diag.error, { [4] = 'reverse' }),
        warn  = clone_with(diag.warn, { [4] = 'reverse' }),
        info  = clone_with(diag.info, { [4] = 'reverse' }),
        todo  = clone_with(diag.hint, { [4] = 'reverse' }),
    }

    return {
        empty = { none, none, none, none },
        comment = { as_hex(0.5 * from_hex(palette.fg.normal)), none, none, none },

        interface = {
        },

        syntax = {
            types         = { palette.yellow.normal, none, none, none },
            fields        = { palette.yellow.normal, none, none, none },
            functions     = { palette.red.normal, none, none, none },
            identifiers   = { palette.fg.normal, none, none, none },
            preproc       = { palette.red.light, none, none, none },
            consts        = { palette.fg.normal, none, none, 'underline' },
            consts_ext    = { palette.yellow.normal, none, none, none },
            literals      = { palette.green.normal, none, none, none },
            literals_ext  = { palette.blue.light, none, none, none },
            keywords      = { palette.yellow.light, none, none, none },
            keywords_flow = { palette.blue.light, none, none, none },
            operators     = { palette.fg.normal, none, none, none },
            delimiters    = { palette.yellow.light, none, none, none },
        },

        text = {
            normal          = { palette.fg.normal, none, none, none },
            strong          = { palette.fg.normal, none, none, 'bold' },
            emphasis        = { palette.fg.normal, none, none, 'italic' },
            underline       = { palette.fg.normal, none, none, 'underline' },
            strike          = { palette.fg.normal, none, none, 'strikethrough' },
            title           = { palette.red.normal, none, none, 'bold' },
            literal         = { palette.red.normal, none, none, none },
            uri             = { palette.blue.normal, none, none, 'underline' },
            math            = { palette.yellow.normal, none, none, none },
            environment     = { palette.cyan.normal, none, none, none },
            environmentName = { palette.cyan.normal, none, none, none },
            reference       = { palette.blue.normal, none, none, none },
            todo            = { palette.blue.normal, none, none, 'reverse' },
            note            = { palette.green.normal, none, none, 'reverse' },
            warning         = { palette.yellow.normal, none, none, 'reverse' },
            danger          = { palette.red.normal, none, none, 'reverse' },
        },

        diag = diag,
        note = note,
    }
end

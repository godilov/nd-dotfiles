local tab_lib    = require 'nd.lib.tab'
local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'
local color_lib  = require 'nd.lib.color'

local clone_with = tab_lib.clone_with

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)

local as_hex     = color_lib.rgb.as_hex
local from_hex   = color_lib.rgb.from_hex


return function(config)
    local palette = config.palette

    nd_assert(is_tab(palette), 'palette must be of type table')

    local none = 'NONE'

    local diag = {
        error = { palette.red.dark, none, none, none },
        warn  = { palette.yellow.dark, none, none, none },
        info  = { palette.green.dark, none, none, none },
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
            types         = { palette.yellow.dark, none, none, none },
            fields        = { palette.yellow.dark, none, none, none },
            functions     = { palette.red.dark, none, none, none },
            identifiers   = { palette.fg.normal, none, none, none },
            preproc       = { palette.red.light, none, none, none },
            consts        = { palette.fg.normal, none, none, 'underline' },
            consts_ext    = { palette.yellow.dark, none, none, none },
            literals      = { palette.green.dark, none, none, none },
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
            title           = { palette.red.dark, none, none, 'bold' },
            literal         = { palette.red.dark, none, none, none },
            uri             = { palette.blue.dark, none, none, 'underline' },
            math            = { palette.yellow.dark, none, none, none },
            environment     = { palette.cyan.dark, none, none, none },
            environmentName = { palette.cyan.dark, none, none, none },
            reference       = { palette.blue.dark, none, none, none },
            todo            = { palette.blue.dark, none, none, 'reverse' },
            note            = { palette.green.dark, none, none, 'reverse' },
            warning         = { palette.yellow.dark, none, none, 'reverse' },
            danger          = { palette.red.dark, none, none, 'reverse' },
        },

        diag = diag,
        note = note,
    }
end

local tab_lib    = require 'nd.lib.core.tab'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local flat       = tab_lib.flat
local clone_with = tab_lib.clone_with

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.highlight.main.ext.syntax'

--
-- Group = { hl, fg, bg, sp, gui, link }
--

return function(config)
    local palette = config.palette
    local accent  = config.accent

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(accent), nd_err, 'fn(): accent must be of type table')

    local syntax = accent.syntax

    return {
        flat { 'Error', accent.diag.error },
        flat { 'Comment', accent.comment },

        flat { 'Constant', syntax.literals },
        flat { 'String', syntax.literals },
        flat { 'Character', syntax.literals },
        flat { 'Number', syntax.literals },
        flat { 'Float', syntax.literals },
        flat { 'Boolean', syntax.literals },

        flat { 'Identifier', syntax.identifiers },
        flat { 'Function', syntax.functions },

        flat { 'Statement', syntax.keywords },
        flat { 'Keyword', syntax.keywords },
        flat { 'Conditional', syntax.keywords_flow },
        flat { 'Repeat', syntax.keywords_flow },
        flat { 'Label', syntax.keywords_flow },
        flat { 'Exception', syntax.keywords_flow },
        flat { 'Operator', syntax.operators },

        flat { 'PreProc', syntax.preproc },
        flat { 'PreCondit', syntax.preproc },
        flat { 'Include', syntax.preproc },
        flat { 'Define', syntax.preproc },
        flat { 'Macro', syntax.preproc },

        flat { 'Type', syntax.types },
        flat { 'StorageClass', syntax.types },
        flat { 'Structure', syntax.types },
        flat { 'Typedef', syntax.types },

        flat { 'Special', syntax.literals_ext },
        flat { 'SpecialChar', syntax.literals_ext },
        flat { 'SpecialComment', syntax.literals_ext },
        flat { 'Tag', clone_with(syntax.delimiters, { [4] = 'bold' }) },
        flat { 'Delimiter', clone_with(syntax.delimiters, { [4] = 'bold' }) },
        flat { 'Debug', syntax.functions },

        flat { 'Todo', accent.note.todo },
        flat { 'Bold', accent.text.strong },
        flat { 'Italic', accent.text.emphasis },
        flat { 'Underlined', accent.text.underline },
    }
end

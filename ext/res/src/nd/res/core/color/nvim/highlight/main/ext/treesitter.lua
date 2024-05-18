local tab_lib    = require 'nd.lib.core.tab'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local flat       = tab_lib.flat

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.color.nvim.highlight.main.ext.treesitter'

--
-- Group = { hl, fg, bg, sp, gui, link }
--

return function(config)
    local palette = config.palette
    local accent  = config.accent

    nd_assert(is_tab(palette), nd_err, 'fn(): palette must be of type table')
    nd_assert(is_tab(accent), nd_err, 'fn(): accent must be of type table')

    local syntax = accent.syntax
    local text   = accent.text

    return {
        -- Misc

        flat { '@error', accent.diag.error },
        flat { '@comment', accent.comment },
        flat { '@comment.documentation', accent.comment },

        -- Punctuation

        flat { '@punctuation', syntax.delimiters },
        flat { '@punctuation.delimiter', syntax.delimiters },
        flat { '@punctuation.bracket', syntax.delimiters },
        flat { '@punctuation.special', syntax.delimiters },

        -- Constants

        flat { '@constant', syntax.consts },
        flat { '@constant.builtin', syntax.consts_ext },
        flat { '@constant.macro', syntax.consts_ext },
        flat { '@string', syntax.literals },
        flat { '@string.regex', syntax.literals_ext },
        flat { '@string.escape', syntax.literals_ext },
        flat { '@string.special', syntax.literals_ext },
        flat { '@character', syntax.literals },
        flat { '@character.special', syntax.literals_ext },
        flat { '@boolean', syntax.literals },
        flat { '@number', syntax.literals },
        flat { '@float', syntax.literals },

        -- Functions

        flat { '@function', syntax.functions },
        flat { '@function.call', syntax.functions },
        flat { '@function.builtin', syntax.functions },
        flat { '@function.macro', syntax.functions },
        flat { '@method', syntax.functions },
        flat { '@method.call', syntax.functions },
        flat { '@parameter', syntax.identifiers },
        flat { '@constructor', syntax.delimiters },
        flat { '@field', syntax.fields },
        flat { '@property', syntax.fields },

        -- Keywords

        flat { '@conditional', syntax.keywords_flow },
        flat { '@repeat', syntax.keywords_flow },
        flat { '@debug', syntax.keywords_flow },
        flat { '@label', syntax.keywords_flow },
        flat { '@exception', syntax.keywords_flow },
        flat { '@keyword', syntax.keywords },
        flat { '@keyword.function', syntax.keywords },
        flat { '@keyword.operator', syntax.keywords },
        flat { '@keyword.return', syntax.keywords },
        flat { '@storageclass', syntax.keywords },
        flat { '@attribute', syntax.keywords },
        flat { '@preproc', syntax.preproc },
        flat { '@include', syntax.preproc },
        flat { '@define', syntax.preproc },
        flat { '@macro', syntax.preproc },
        flat { '@type', syntax.types },
        flat { '@type.builtin', syntax.types },
        flat { '@type.definition', syntax.types },
        flat { '@type.qualifier', syntax.types },
        flat { '@operator', syntax.operators },
        flat { '@namespace', syntax.delimiters },
        flat { '@symbol', syntax.delimiters },

        -- Variables

        flat { '@variable', syntax.identifiers },
        flat { '@variable.builtin', syntax.identifiers },

        -- Text

        flat { '@text', text.normal },
        flat { '@text.strong', text.strong },
        flat { '@text.emphasis', text.emphasis },
        flat { '@text.underline', text.underline },
        flat { '@text.strike', text.strike },
        flat { '@text.title', text.title },
        flat { '@text.literal', text.literal },
        flat { '@text.uri', text.uri },
        flat { '@text.math', text.math },
        flat { '@text.environment', text.environment },
        flat { '@text.environmentName', text.environmentName },
        flat { '@text.reference', text.reference },
        flat { '@text.note', text.note },
        flat { '@text.warning', text.warning },
        flat { '@text.danger', text.danger },
        flat { '@todo', text.todo },

        -- Tags

        flat { '@tag', syntax.fields },
        flat { '@tag.attribute', syntax.functions },
        flat { '@tag.delimiter', syntax.delimiters },

        -- Lsp

        flat { '@lsp.type.comment', accent.empty },
        flat { '@lsp.type.variable', accent.empty },
        flat { '@lsp.type.property', accent.empty },
        flat { '@lsp.type.parameter', accent.empty },
        flat { '@lsp.type.function', accent.empty },
        flat { '@lsp.type.macro', accent.empty },
        flat { '@lsp.type.enum', accent.empty },
        flat { '@lsp.type.enumMember', accent.empty },
        flat { '@lsp.type.type', accent.empty },
        flat { '@lsp.type.typeParameter', accent.empty },
        flat { '@lsp.type.struct', accent.empty },
        flat { '@lsp.type.class', accent.empty },
        flat { '@lsp.type.method', accent.empty },
        flat { '@lsp.type.namespace', accent.empty },
        flat { '@lsp.type.interface', accent.empty },
        flat { '@lsp.type.decorator', accent.empty },
    }
end

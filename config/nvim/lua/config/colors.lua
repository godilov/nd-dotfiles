local function set_hls()
end

local function set_treesitter_hls()
end

local function get_lualine_hls()
end

local palette = {
    bg      = '#000000',
    fg      = '#FFFFFF',
    black   = { dark = '#0D0D0D', core = '#1A1A1A', light = '#262626' },
    white   = { dark = '#D9D9D9', core = '#E6E6E6', light = '#F2F2F2' },
    red     = { dark = '#FF6666', core = '#FF9999', light = '#FFCCCC' },
    yellow  = { dark = '#FFD966', core = '#FFE699', light = '#FFF2CC' },
    green   = { dark = '#D9FF66', core = '#E6FF99', light = '#F2FFCC' },
    cyan    = { dark = '#66FFFF', core = '#99FFFF', light = '#CCFFFF' },
    blue    = { dark = '#66B3FF', core = '#99CCFF', light = '#CCE6FF' },
    magenta = { dark = '#FF66D9', core = '#FF99E6', light = '#FFCCF2' },
}

local diag = {
    error = { fg = palette.red.light, reverse = true },
    warn  = { fg = palette.yellow.light, reverse = true },
    hint  = { fg = palette.green.light, reverse = true },
    info  = { fg = palette.blue.light, reverse = true },
    ok    = { fg = palette.white.light, reverse = true },
}

local diff = {
    add = { fg = palette.green.core },
    mod = { fg = palette.yellow.core },
    rem = { fg = palette.red.core },
}

local editor = {
    normal    = { fg = palette.fg, bg = palette.bg },
    invisible = { fg = palette.bg, },
    cursor    = { reverse = true },
    cursorx   = { bg = palette.black.light },
    menu      = { fg = palette.white.light, bg = palette.black.light },
    menusel   = { fg = palette.black.light, bg = palette.yellow.light },
    search    = { fg = palette.yellow.light, reverse = true },
    searchsel = { fg = palette.red.light, reverse = true },
    number    = { fg = palette.yellow.light },
    numbersel = { fg = palette.yellow.light, reverse = true },
}

local status = {
    error = { fg = palette.red.light, reverse = true },
    warn  = { fg = palette.yellow.light, reverse = true },
    info  = { fg = palette.green.light, reverse = true },
    note  = { fg = palette.blue.light, reverse = true },
}

local syntax = {
    ['variable']            = { fg = palette.white.light },
    ['constant']            = { fg = palette.white.light },

    ['module']              = { fg = palette.yellow.light },
    ['label']               = { fg = palette.blue.light },

    ['literal']             = { fg = palette.green.core },
    ['literal.special']     = { fg = palette.yellow.core },
    ['literal.escape']      = { fg = palette.blue.core },
    ['literal.regexp']      = { fg = palette.yellow.core },
    ['literal.url']         = { fg = palette.yellow.core, underline = true },

    ['type']                = { fg = palette.yellow.core },
    ['attribute']           = { fg = palette.yellow.light },
    ['property']            = { fg = palette.white.light },

    ['function']            = { fg = palette.red.light },
    ['function.builtin']    = { fg = palette.red.core },
    ['function.call']       = { fg = palette.red.core },
    ['function.macro']      = { fg = palette.red.core },

    ['constructor']         = { fg = palette.red.core },
    ['operator']            = { fg = palette.white.light },
    ['keyword']             = { fg = palette.blue.light },

    ['punctuation']         = { fg = palette.white.light },
    ['punctuation.special'] = { fg = palette.yellow.core },

    ['comment']             = { fg = palette.black.light },
    ['comment.error']       = status.error,
    ['comment.warning']     = status.warn,
    ['comment.todo']        = status.info,
    ['comment.note']        = status.note,
}

local groups = {
    { 'ColorColumn',                  editor.cursorx },
    { 'Conceal',                      {} },
    { 'CurSearch',                    editor.searchsel },
    { 'Cursor',                       editor.cursor },
    { 'lCursor',                      editor.cursor },
    { 'CursorIM',                     editor.cursor },
    { 'CursorColumn',                 editor.cursorx },
    { 'CursorLine',                   editor.cursorx },
    { 'Directory',                    {} },

    { 'DiffAdd',                      diff.add },
    { 'DiffChange',                   diff.mod },
    { 'DiffDelete',                   diff.rem },
    { 'DiffText',                     diff.mod },

    { 'EndOfBuffer',                  editor.invisible },
    { 'TermCursor',                   editor.cursor },
    { 'TermCursorNC',                 editor.cursor },
    { 'WinSeparator',                 editor.normal },
    { 'Folded',                       {} },
    { 'FoldColumn',                   editor.normal },
    { 'SignColumn',                   editor.normal },
    { 'IncSearch',                    editor.searchsel },
    { 'Substitute',                   editor.searchsel },
    { 'LineNr',                       editor.numbersel },
    { 'LineNrAbove',                  editor.number },
    { 'LineNrBelow',                  editor.number },
    { 'CursorLineNr',                 {} },
    { 'CursorLineFold',               {} },
    { 'CursorLineSign',               {} },
    { 'MatchParen',                   {} },
    { 'NonText',                      {} },

    { 'MsgArea',                      editor.normal },
    { 'MsgSeparator',                 editor.normal },
    { 'ErrorMsg',                     status.error },
    { 'WarningMsg',                   status.warn },
    { 'ModeMsg',                      status.info },
    { 'MoreMsg',                      status.note },

    { 'Normal',                       editor.normal },
    { 'NormalNC',                     editor.normal },
    { 'NormalFloat',                  editor.normal },

    { 'FloatTitle',                   {} },
    { 'FloatBorder',                  {} },
    { 'FloatFooter',                  {} },

    { 'Pmenu',                        editor.menu },
    { 'PmenuSel',                     editor.menusel },
    { 'PmenuKind',                    editor.menu },
    { 'PmenuKindSel',                 editor.menusel },
    { 'PmenuExtra',                   editor.menu },
    { 'PmenuExtraSel',                editor.menusel },
    { 'PmenuSbar',                    editor.menu },
    { 'PmenuThumb',                   editor.menusel },

    { 'Question',                     {} },
    { 'QuickFixLine',                 {} },
    { 'Search',                       editor.search },
    { 'SnippetTabstop',               {} },
    { 'SpecialKey',                   {} },
    { 'SpellBad',                     {} },
    { 'SpellCap',                     {} },
    { 'SpellLocal',                   {} },
    { 'SpellRare',                    {} },
    { 'StatusLine',                   {} },
    { 'StatusLineNC',                 {} },
    { 'TabLine',                      {} },
    { 'TabLineFill',                  {} },
    { 'TabLineSel',                   {} },
    { 'Title',                        {} },
    { 'Visual',                       {} },
    { 'VisualNOS',                    {} },
    { 'Whitespace',                   {} },
    { 'WildMenu',                     {} },
    { 'WinBar',                       {} },
    { 'WinBarNC',                     {} },

    { 'Menu',                         {} },
    { 'Scrollbar',                    {} },
    { 'Tooltip',                      {} },

    { 'Comment',                      syntax['comment'] },

    { 'Constant',                     syntax['constant'] },
    { 'String',                       syntax['literal'] },
    { 'Character',                    syntax['literal'] },
    { 'Number',                       syntax['literal'] },
    { 'Boolean',                      syntax['literal'] },
    { 'Float',                        syntax['literal'] },

    { 'Identifier',                   syntax['variable'] },
    { 'Function',                     syntax['function'] },

    { 'Statement',                    syntax['keyword'] },
    { 'Conditional',                  syntax['keyword'] },
    { 'Repeat',                       syntax['keyword'] },
    { 'Label',                        syntax['keyword'] },
    { 'Operator',                     syntax['operator'] },
    { 'Keyword',                      syntax['keyword'] },
    { 'Exception',                    syntax['keyword'] },

    { 'PreProc',                      syntax['function.macro'] },
    { 'Include',                      syntax['keyword'] },
    { 'Define',                       syntax['keyword'] },
    { 'Macro',                        syntax['keyword'] },
    { 'PreCondit',                    syntax['keyword'] },

    { 'Type',                         syntax['type'] },
    { 'StorageClass',                 syntax['type'] },
    { 'Structure',                    syntax['type'] },
    { 'Typedef',                      syntax['type'] },

    { 'Special',                      syntax['literal.special'] },
    { 'SpecialChar',                  syntax['literal.special'] },
    { 'Tag',                          syntax['literal'] },
    { 'Delimiter',                    syntax['literal'] },
    { 'SpecialComment',               syntax['literal'] },
    { 'Debug',                        syntax['literal.special'] },

    { 'Underlined',                   { fg = palette.white.light, underline = true } },

    { 'Error',                        { fg = palette.red.core } },

    { 'Todo',                         syntax['comment.note'] },

    { 'Added',                        diff.add },
    { 'Changed',                      diff.mod },
    { 'Removed',                      diff.rem },

    { '@variable',                    syntax['variable'] },
    { '@variable.builtin',            syntax['variable'] },
    { '@variable.parameter',          syntax['variable'] },
    { '@variable.parameter.builtin',  syntax['variable'] },
    { '@variable.member',             syntax['variable'] },

    { '@constant',                    syntax['constant'] },
    { '@constant.builtin',            syntax['constant'] },
    { '@constant.macro',              syntax['constant'] },

    { '@module',                      syntax['module'] },
    { '@module.builtin',              syntax['module'] },
    { '@label',                       syntax['label'] },

    { '@string',                      syntax['literal'] },
    { '@string.documentation',        syntax['literal'] },
    { '@string.regexp',               syntax['literal.regexp'] },
    { '@string.escape',               syntax['literal.escape'] },
    { '@string.special',              syntax['literal.special'] },
    { '@string.special.symbol',       syntax['literal.special'] },
    { '@string.special.path',         syntax['literal.special'] },
    { '@string.special.url',          syntax['literal.url'] },

    { '@character',                   syntax['literal'] },
    { '@character.special',           syntax['literal.special'] },

    { '@boolean',                     syntax['literal'] },
    { '@number',                      syntax['literal'] },
    { '@number.float',                syntax['literal'] },

    { '@type',                        syntax['type'] },
    { '@type.builtin',                syntax['type'] },
    { '@type.definition',             syntax['type'] },

    { '@attribute',                   syntax['attribute'] },
    { '@attribute.builtin',           syntax['attribute'] },
    { '@property',                    syntax['property'] },

    { '@function',                    syntax['function'] },
    { '@function.builtin',            syntax['function.builtin'] },
    { '@function.call',               syntax['function.call'] },
    { '@function.macro',              syntax['function.macro'] },

    { '@function.method',             syntax['function'] },
    { '@function.method.call',        syntax['function.call'] },

    { '@constructor',                 syntax['constructor'] },
    { '@operator',                    syntax['operator'] },

    { '@keyword',                     syntax['keyword'] },
    { '@keyword.coroutine',           syntax['keyword'] },
    { '@keyword.function',            syntax['keyword'] },
    { '@keyword.operator',            syntax['keyword'] },
    { '@keyword.import',              syntax['keyword'] },
    { '@keyword.type',                syntax['keyword'] },
    { '@keyword.modifier',            syntax['keyword'] },
    { '@keyword.repeat',              syntax['keyword'] },
    { '@keyword.return',              syntax['keyword'] },
    { '@keyword.debug',               syntax['keyword'] },
    { '@keyword.exception',           syntax['keyword'] },

    { '@keyword.conditional',         syntax['keyword'] },
    { '@keyword.conditional.ternary', syntax['keyword'] },

    { '@keyword.directive',           syntax['keyword'] },
    { '@keyword.directive.define',    syntax['keyword'] },

    { '@punctuation.delimiter',       syntax['punctuation'] },
    { '@punctuation.bracket',         syntax['punctuation'] },
    { '@punctuation.special',         syntax['punctuation.special'] },

    { '@comment',                     syntax['comment'] },
    { '@comment.documentation',       syntax['comment'] },
    { '@comment.error',               syntax['comment.error'] },
    { '@comment.warning',             syntax['comment.warning'] },
    { '@comment.todo',                syntax['comment.todo'] },
    { '@comment.note',                syntax['comment.note'] },

    { '@markup.strong',               { fg = palette.white.light, bold = true } },
    { '@markup.italic',               { fg = palette.white.light, italic = true } },
    { '@markup.strikethrough',        { fg = palette.white.light, strikethrough = true } },
    { '@markup.underline',            { fg = palette.white.light, underline = true } },

    { '@markup.heading',              { fg = palette.white.light, bold = true } },
    { '@markup.heading.1',            { fg = palette.red.light, bold = true } },
    { '@markup.heading.2',            { fg = palette.yellow.light, bold = true } },
    { '@markup.heading.3',            { fg = palette.green.light, bold = true } },
    { '@markup.heading.4',            { fg = palette.white.light, bold = true } },
    { '@markup.heading.5',            { fg = palette.white.light, bold = true } },
    { '@markup.heading.6',            { fg = palette.white.light, bold = true } },

    { '@markup.quote',                { fg = palette.white.light } },
    { '@markup.math',                 { fg = palette.yellow.light } },

    { '@markup.link',                 { fg = palette.yellow.core } },
    { '@markup.link.label',           { fg = palette.red.core } },
    { '@markup.link.url',             { fg = palette.yellow.core, underline = true } },

    { '@markup.raw',                  { fg = palette.yellow.light } },
    { '@markup.raw.block',            { fg = palette.red.light } },

    { '@markup.list',                 { fg = palette.yellow.light } },
    { '@markup.list.checked',         { fg = palette.green.light } },
    { '@markup.list.unchecked',       { fg = palette.red.light } },

    { '@diff.plus',                   diff.add },
    { '@diff.minus',                  diff.rem },
    { '@diff.delta',                  diff.mod },

    { '@tag',                         { fg = palette.red.light } },
    { '@tag.builtin',                 { fg = palette.green.light } },
    { '@tag.attribute',               { fg = palette.yellow.light } },
    { '@tag.delimiter',               { fg = palette.white.light } },
}

-- for _, v in ipairs(groups) do
--     vim.api.nvim_set_hl(0, v[1], v[2])
-- end

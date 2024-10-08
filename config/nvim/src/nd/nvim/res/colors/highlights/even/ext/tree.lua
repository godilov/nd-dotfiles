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
        { 'NvimTreeNormal',            none,                 none,                none, none,  'Normal' },
        { 'NvimTreeNormalFloat',       none,                 none,                none, none,  'NvimTreeNormal' },
        { 'NvimTreeNormalNC',          none,                 none,                none, none,  'NvimTreeNormal' },
        { 'NvimTreeWindowPicker',      palette.bg.normal,    palette.yellow.dark, none, 'bold' },
        { 'NvimTreeSymlink',           none,                 none,                none, none },
        { 'NvimTreeSymlinkIcon',       none,                 none,                none, none },
        { 'NvimTreeSymlinkFolderName', none,                 none,                none, none },
        { 'NvimTreeRootFolder',        palette.red.dark,     none,                none, 'bold' },
        { 'NvimTreeFolderName',        none,                 none,                none, none },
        { 'NvimTreeFolderIcon',        none,                 none,                none, none },
        { 'NvimTreeOpenedFolderIcon',  palette.yellow.light, none,                none, none },
        { 'NvimTreeClosedFolderIcon',  palette.yellow.dark,  none,                none, none },
        { 'NvimTreeFileIcon',          none,                 none,                none, none },
        { 'NvimTreeEmptyFolderName',   none,                 none,                none, none },
        { 'NvimTreeOpenedFolderName',  none,                 none,                none, none },
        { 'NvimTreeExecFile',          palette.green.dark,   none,                none, none },
        { 'NvimTreeOpenedFile',        none,                 none,                none, none },
        { 'NvimTreeModifiedFile',      none,                 none,                none, none },
        { 'NvimTreeSpecialFile',       none,                 none,                none, none },
        { 'NvimTreeImageFile',         none,                 none,                none, none },
        { 'NvimTreeIndentMarker',      none,                 none,                none, none },
        --
        { 'NvimTreeGitDirty',          palette.cyan.light,   none,                none, none },
        { 'NvimTreeGitStaged',         palette.white.light,  none,                none, none },
        { 'NvimTreeGitMerge',          palette.blue.light,   none,                none, none },
        { 'NvimTreeGitRenamed',        palette.yellow.light, none,                none, none },
        { 'NvimTreeGitNew',            palette.green.light,  none,                none, none },
        { 'NvimTreeGitDeleted',        palette.red.light,    none,                none, none },
    }
end

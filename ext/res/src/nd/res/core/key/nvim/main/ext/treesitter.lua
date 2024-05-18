local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim.main.ext.treesitter'

return function(config)
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_str(leader.lsp), nd_err, 'fn(): leader.lsp must be of type string')
    nd_assert(is_str(leader.lsp_goto), nd_err, 'fn(): leader.lsp_goto must be of type string')
    nd_assert(is_tab(opts) or not opts, nd_err, 'fn(): opts must be of type table or nil')

    return function()
        return {
            toggle_query_editor       = 'o',
            toggle_hl_groups          = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes    = 'a',
            toggle_language_display   = 'I',
            focus_language            = 'f',
            unfocus_language          = 'F',
            update                    = 'R',
            goto_node                 = '<cr>',
            show_help                 = '?',
        }
    end
end

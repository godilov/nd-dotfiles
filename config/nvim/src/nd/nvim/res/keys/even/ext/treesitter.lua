local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local is_str     = type_lib.is_str
local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_NVIM_IS_DEBUG)

return function(config)
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(leader), 'leader must be of type table')
    nd_assert(is_str(leader.lsp), 'leader.lsp must be of type string')
    nd_assert(is_str(leader.lsp_goto), 'leader.lsp_goto must be of type string')
    nd_assert(is_tab(opts) or not opts, 'opts must be of type table or nil')

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

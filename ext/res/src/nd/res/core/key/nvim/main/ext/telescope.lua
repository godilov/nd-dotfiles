local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim.main.ext.telescope'

return function(config)
    local api    = config.api
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(api.telescope, nd_err, 'fn(): api.telescope must be of type value')

    nd_assert(is_tab(leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_tab(opts) or not opts, nd_err, 'fn(): opts must be of type table or nil')

    return function()
        local actions = api.actions

        return {
            i = {
                ['<Up>']       = actions.move_selection_previous,
                ['<Down>']     = actions.move_selection_next,
                ['<Left>']     = actions.toggle_selection + actions.move_selection_worse,
                ['<Right>']    = actions.toggle_selection + actions.move_selection_better,

                ['<Tab>']      = actions.move_selection_previous,
                ['<S-Tab>']    = actions.move_selection_next,

                ['<CR>']       = actions.select_default,
                ['<C-x>']      = actions.select_horizontal,
                ['<C-v>']      = actions.select_vertical,
                ['<C-t>']      = actions.select_tab,

                ['<C-u>']      = actions.preview_scrolling_up,
                ['<C-d>']      = actions.preview_scrolling_down,

                ['<C-q>']      = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>']      = actions.send_selected_to_qflist + actions.open_qflist,

                ['<C-n>']      = false,
                ['<C-p>']      = false,

                ['<PageUp>']   = false,
                ['<PageDown>'] = false,

                ['<C-c>']      = false,

                ['<C-l>']      = false,
                ['<C-/>']      = false,
                ['<C-_>']      = false,
                ['<C-w>']      = false,
            },
            n = {
                ['<Up>']       = actions.move_selection_previous,
                ['<Down>']     = actions.move_selection_next,
                ['<Left>']     = actions.toggle_selection + actions.move_selection_worse,
                ['<Right>']    = actions.toggle_selection + actions.move_selection_better,

                ['<Tab>']      = actions.move_selection_previous,
                ['<S-Tab>']    = actions.move_selection_next,
                ['k']          = actions.move_selection_previous,
                ['j']          = actions.move_selection_next,

                ['<CR>']       = actions.select_default,
                ['<C-x>']      = actions.select_horizontal,
                ['<C-v>']      = actions.select_vertical,
                ['<C-t>']      = actions.select_tab,

                ['<C-u>']      = actions.preview_scrolling_up,
                ['<C-d>']      = actions.preview_scrolling_down,

                ['q']          = actions.close,
                ['<Esc>']      = actions.close,

                ['<C-q>']      = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>']      = actions.send_selected_to_qflist + actions.open_qflist,

                ['gg']         = actions.move_to_top,
                ['G']          = actions.move_to_bottom,

                ['?']          = actions.which_key,

                ['<PageUp>']   = false,
                ['<PageDown>'] = false,

                ['H']          = false,
                ['M']          = false,
                ['L']          = false,
            },
        }
    end
end

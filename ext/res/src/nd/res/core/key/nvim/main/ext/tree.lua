local tab_lib    = require 'nd.lib.core.tab'
local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local merge      = tab_lib.merge

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim.main.ext.tree'

return function(config)
    local api    = config.api
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(api.tree, nd_err, 'fn(): api.tree must be of type value')

    nd_assert(is_tab(leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_tab(opts) or not opts, nd_err, 'fn(): opts must be of type table or nil')

    return function(bufnr)
        local tree = api.tree
        local opts_buf = merge {
            { buffer = bufnr, noremap = true, silent = true, nowait = true },
            opts,
        }

        return {
            { 'n', '<C-]>',          tree.tree.change_root_to_node,       opts_buf },
            { 'n', '<C-e>',          tree.node.open.replace_tree_buffer,  opts_buf },
            { 'n', '<C-k>',          tree.node.show_info_popup,           opts_buf },
            { 'n', '<C-r>',          tree.fs.rename_sub,                  opts_buf },
            { 'n', '<C-t>',          tree.node.open.tab,                  opts_buf },
            { 'n', '<C-v>',          tree.node.open.vertical,             opts_buf },
            { 'n', '<C-x>',          tree.node.open.horizontal,           opts_buf },
            { 'n', '<BS>',           tree.node.navigate.parent_close,     opts_buf },
            { 'n', '<CR>',           tree.node.open.edit,                 opts_buf },
            { 'n', '<Tab>',          tree.node.open.preview,              opts_buf },
            { 'n', '>',              tree.node.navigate.sibling.next,     opts_buf },
            { 'n', '<',              tree.node.navigate.sibling.prev,     opts_buf },
            { 'n', '.',              tree.node.run.cmd,                   opts_buf },
            { 'n', '-',              tree.tree.change_root_to_parent,     opts_buf },
            { 'n', 'a',              tree.fs.create,                      opts_buf },
            { 'n', 'bmv',            tree.marks.bulk.move,                opts_buf },
            { 'n', 'B',              tree.tree.toggle_no_buffer_filter,   opts_buf },
            { 'n', 'c',              tree.fs.copy.node,                   opts_buf },
            { 'n', 'C',              tree.tree.toggle_git_clean_filter,   opts_buf },
            { 'n', '[c',             tree.node.navigate.git.prev,         opts_buf },
            { 'n', ']c',             tree.node.navigate.git.next,         opts_buf },
            { 'n', 'd',              tree.fs.remove,                      opts_buf },
            { 'n', 'D',              tree.fs.trash,                       opts_buf },
            { 'n', 'E',              tree.tree.expand_all,                opts_buf },
            { 'n', 'e',              tree.fs.rename_basename,             opts_buf },
            { 'n', ']e',             tree.node.navigate.diagnostics.next, opts_buf },
            { 'n', '[e',             tree.node.navigate.diagnostics.prev, opts_buf },
            { 'n', 'F',              tree.live_filter.clear,              opts_buf },
            { 'n', 'f',              tree.live_filter.start,              opts_buf },
            { 'n', 'g?',             tree.tree.toggle_help,               opts_buf },
            { 'n', 'gy',             tree.fs.copy.absolute_path,          opts_buf },
            { 'n', 'H',              tree.tree.toggle_hidden_filter,      opts_buf },
            { 'n', 'I',              tree.tree.toggle_gitignore_filter,   opts_buf },
            { 'n', 'J',              tree.node.navigate.sibling.last,     opts_buf },
            { 'n', 'K',              tree.node.navigate.sibling.first,    opts_buf },
            { 'n', 'm',              tree.marks.toggle,                   opts_buf },
            { 'n', 'o',              tree.node.open.edit,                 opts_buf },
            { 'n', 'O',              tree.node.open.no_window_picker,     opts_buf },
            { 'n', 'p',              tree.fs.paste,                       opts_buf },
            { 'n', 'P',              tree.node.navigate.parent,           opts_buf },
            { 'n', 'q',              tree.tree.close,                     opts_buf },
            { 'n', 'r',              tree.fs.rename,                      opts_buf },
            { 'n', 'R',              tree.tree.reload,                    opts_buf },
            { 'n', 's',              tree.node.run.system,                opts_buf },
            { 'n', 'S',              tree.tree.search_node,               opts_buf },
            { 'n', 'U',              tree.tree.toggle_custom_filter,      opts_buf },
            { 'n', 'W',              tree.tree.collapse_all,              opts_buf },
            { 'n', 'x',              tree.fs.cut,                         opts_buf },
            { 'n', 'y',              tree.fs.copy.filename,               opts_buf },
            { 'n', 'Y',              tree.fs.copy.relative_path,          opts_buf },
            { 'n', '<2-LeftMouse>',  tree.node.open.edit,                 opts_buf },
            { 'n', '<2-RightMouse>', tree.tree.change_root_to_node,       opts_buf },
            --
            --
            --
            { 'n', '<CR>',           tree.node.open.edit,                 opts_buf },
            { 'n', 'o',              tree.node.open.edit,                 opts_buf },
            { 'n', '<2-LeftMouse>',  tree.node.open.edit,                 opts_buf },
            { 'n', '<C-e>',          tree.node.open.replace_tree_buffer,  opts_buf },
            { 'n', 'O',              tree.node.open.no_window_picker,     opts_buf },
            { 'n', '<C-]>',          tree.tree.change_root_to_node,       opts_buf },
            { 'n', '<2-RightMouse>', tree.tree.change_root_to_node,       opts_buf },
            { 'n', '<C-v>',          tree.node.open.vertical,             opts_buf },
            { 'n', '<C-x>',          tree.node.open.horizontal,           opts_buf },
            { 'n', '<C-t>',          tree.node.open.tab,                  opts_buf },
            { 'n', '<',              tree.node.navigate.sibling.prev,     opts_buf },
            { 'n', '>',              tree.node.navigate.sibling.next,     opts_buf },
            { 'n', 'P',              tree.node.navigate.parent,           opts_buf },
            { 'n', '<BS>',           tree.node.navigate.parent_close,     opts_buf },
            { 'n', '<Tab>',          tree.node.open.preview,              opts_buf },
            { 'n', 'K',              tree.node.navigate.sibling.first,    opts_buf },
            { 'n', 'J',              tree.node.navigate.sibling.last,     opts_buf },
            { 'n', 'I',              tree.tree.toggle_gitignore_filter,   opts_buf },
            { 'n', 'H',              tree.tree.toggle_hidden_filter,      opts_buf },
            { 'n', 'U',              tree.tree.toggle_custom_filter,      opts_buf },
            { 'n', 'R',              tree.tree.reload,                    opts_buf },
            { 'n', 'a',              tree.fs.create,                      opts_buf },
            { 'n', 'd',              tree.fs.remove,                      opts_buf },
            { 'n', 'D',              tree.fs.trash,                       opts_buf },
            { 'n', 'r',              tree.fs.rename,                      opts_buf },
            { 'n', '<C-r>',          tree.fs.rename_sub,                  opts_buf },
            { 'n', 'x',              tree.fs.cut,                         opts_buf },
            { 'n', 'c',              tree.fs.copy.node,                   opts_buf },
            { 'n', 'p',              tree.fs.paste,                       opts_buf },
            { 'n', 'y',              tree.fs.copy.filename,               opts_buf },
            { 'n', 'Y',              tree.fs.copy.relative_path,          opts_buf },
            { 'n', 'gy',             tree.fs.copy.absolute_path,          opts_buf },
            { 'n', '[e',             tree.node.navigate.diagnostics.prev, opts_buf },
            { 'n', '[c',             tree.node.navigate.git.prev,         opts_buf },
            { 'n', ']e',             tree.node.navigate.diagnostics.next, opts_buf },
            { 'n', ']c',             tree.node.navigate.git.next,         opts_buf },
            { 'n', '-',              tree.tree.change_root_to_parent,     opts_buf },
            { 'n', 's',              tree.node.run.system,                opts_buf },
            { 'n', 'f',              tree.live_filter.start,              opts_buf },
            { 'n', 'F',              tree.live_filter.clear,              opts_buf },
            { 'n', 'q',              tree.tree.close,                     opts_buf },
            { 'n', '<Esc>',          tree.tree.close,                     opts_buf },
            { 'n', 'W',              tree.tree.collapse_all,              opts_buf },
            { 'n', 'E',              tree.tree.expand_all,                opts_buf },
            { 'n', 'S',              tree.tree.search_node,               opts_buf },
            { 'n', '.',              tree.node.run.cmd,                   opts_buf },
            { 'n', '<C-k>',          tree.node.show_info_popup,           opts_buf },
            { 'n', 'g?',             tree.tree.toggle_help,               opts_buf },
            { 'n', 'm',              tree.marks.toggle,                   opts_buf },
            { 'n', 'bmv',            tree.marks.bulk.move,                opts_buf },
        }
    end
end

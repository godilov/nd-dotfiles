local str_lib        = require 'nd.lib.str'

local keys_cache_res = require 'nd.res.nvim.keys.cache'

local keys_fn        = require 'nd.nvim.keys'

local concat2s       = str_lib.concat2s

local tree           = require 'nvim-tree'
local telescope      = require 'telescope'
local sessions       = require 'sessions'
local workspaces     = require 'workspaces'

return function(config)
    local key_scheme = keys_cache_res.get(config.keys)

    keys_fn(key_scheme.editor_fn())

    tree.setup {
        on_attach = function(bufnr)
            keys_fn(key_scheme.tree_fn(bufnr))
        end,
        view = {
            width = 48,
        },
        renderer = {
            icons = config.res.tree.icons,
        },
    }

    telescope.setup {
        defaults = {
            borderchars = config.res.telescope.borderchars,
            mappings = key_scheme.telescope_fn(),
        },
    }

    sessions.setup {
        session_filepath = '.session',
    }

    workspaces.setup {
        path = concat2s(vim.fn.stdpath 'data', '/workspaces'),
        hooks = {
            open = function()
                sessions.load(nil, { silent = true })
            end,
        },
    }

    telescope.load_extension 'workspaces'
end

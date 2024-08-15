local res          = require 'nd.nvim.res'
local cache_res    = require 'nd.nvim.res.cache'
local scheme_res   = require 'nd.nvim.res.scheme'

local apply_colors = scheme_res.apply_colors

local colorizer    = require 'colorizer'
local lualine      = require 'lualine'
local bufferline   = require 'bufferline'
local dashboard    = require 'dashboard'
local markdown     = require 'render-markdown'

return function(config)
    local color_scheme = cache_res.get_colors(config.colors)

    apply_colors(color_scheme.highlight)

    colorizer.setup { '*' }

    lualine.setup {
        options = {
            theme = color_scheme.special.lualine,
        },
    }

    bufferline.setup {
        options = {
            mode = 'tabs',
            numbers = 'none',
            close_command = '',
            right_mouse_command = '',
            left_mouse_command = '',
            middle_mouse_command = '',
            always_show_bufferline = true,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(count, _, _, _)
                return '(' .. count .. ')'
            end,
        },
    }

    dashboard.setup {
        theme = 'hyper',
        disable_move = true,
        shortcut_type = 'letter',
        config = res.dashboard(config).config,
    }

    markdown.setup {}
end

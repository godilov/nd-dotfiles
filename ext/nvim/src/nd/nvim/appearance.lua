local cache_res    = require 'nd.nvim.res.cache'

local scheme       = require 'nd.nvim.scheme'

local apply_colors = scheme.apply_colors

local colorizer    = require 'colorizer'
local lualine      = require 'lualine'
local bufferline   = require 'bufferline'
local dashboard    = require 'dashboard'

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
        config = config.res.dashboard.config,
    }
end

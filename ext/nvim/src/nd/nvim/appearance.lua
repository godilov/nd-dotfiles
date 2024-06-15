local color_cache_res = require 'nd.res.color.cache'

local colors_fn       = require 'nd.nvim.colors'

local color_scheme_fn = color_cache_res.get_nvim

local colorizer       = require 'colorizer'
local lualine         = require 'lualine'
local bufferline      = require 'bufferline'
local dashboard       = require 'dashboard'

return function(config)
    local color_scheme = color_scheme_fn(config.color)

    colors_fn(color_scheme.highlight)

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
            always_show_bufferline = false,
            diagnostics = 'nvim_lsp',
            diagnostics_update_in_insert = true,
            diagnostics_indicator = function(count, _, _, _)
                return '(' .. count .. ')'
            end,
        },
    }

    dashboard.setup {
        theme = 'hyper',
        disable_move = true,
        shortcut_type = 'letter',
        config = color_scheme.etc.dashboard.config,
    }
end

local res          = require 'nd.nvim.res'
local cache_res    = require 'nd.nvim.res.cache'
local scheme_res   = require 'nd.nvim.res.scheme'

local apply_colors = scheme_res.apply_colors

local colorizer    = require 'colorizer'
local lualine      = require 'lualine'
local bufferline   = require 'bufferline'
local dashboard    = require 'dashboard'

return function(config)
    local color_scheme = cache_res.get_colors(config.colors)

    apply_colors(color_scheme.highlight)

    colorizer.setup({ 'css', 'lua' }, {
        names = false,
        RGB = false,
        RRGGBB = true,
        RRGGBBAA = true,
        rgb_fn = true,
        hsl_fn = true,
        css_fn = true,
    });

    lualine.setup {
        options = {
            theme = color_scheme.special.lualine,
            component_separators = { left = '|', right = '|' },
            section_separators = { left = '', right = '' },
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff', 'diagnostics' },
            lualine_c = { {
                'filename',
                file_status = true,
                path = 1,
            } },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
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
end

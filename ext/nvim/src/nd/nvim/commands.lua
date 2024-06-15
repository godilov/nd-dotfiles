local fn_lib    = require 'nd.lib.fn'

local key_res   = require 'nd.res.key.cache'
local color_res = require 'nd.res.color.cache'

local keys_fn   = require 'nd.nvim.keys'
local colors_fn = require 'nd.nvim.colors'

local keys      = fn_lib.keys
local ivals     = fn_lib.ivals
local filter    = fn_lib.filter
local each      = fn_lib.each

local format    = string.format
local match     = string.match
local gsub      = string.gsub


local unload          = nil
local nd_apply_config = nil
local nd_apply_file   = nil


unload = function(mods)
    each(function(mod)
        each(function(name)
            package.loaded[name] = nil
        end, filter(function(name)
            return match(name, format('^%s', gsub(mod, '%.', '%.')))
        end, keys(package.loaded)))
    end, ivals(mods))
end

nd_apply_config = function(config)
    return function()
        vim.cmd 'wa'

        unload {
            'nd.nvim.options',
            'nd.res.key.nvim',
            'nd.res.color.nvim',
        }

        local key_scheme   = key_res.get_nvim(config.keys, true)
        local color_scheme = color_res.get_nvim(config.colors, true)

        keys_fn(key_scheme.editor_fn())
        colors_fn(color_scheme.highlight)
        require 'nd.nvim.options' ()

        print 'Config has been applied!'
    end
end

nd_apply_file = function()
    return function()
        vim.cmd 'wa'
        vim.cmd 'source %'

        print 'File has been applied!'
    end
end

return function(config)
    vim.api.nvim_create_user_command('NdApplyConfig', nd_apply_config(config), {})
    vim.api.nvim_create_user_command('NdApplyFile', nd_apply_file(), {})
end

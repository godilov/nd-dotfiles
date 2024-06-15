local fn_lib   = require 'nd.lib.fn'
local str_lib  = require 'nd.lib.str'

local ivals    = fn_lib.ivals
local map      = fn_lib.map
local collect  = fn_lib.collect
local each     = fn_lib.each

local concat2s = str_lib.concat2s

local format   = string.format

local concat   = table.concat


local as_str       = nil
local apply_colors = nil
local apply_keys   = nil


as_str = function(val)
    local link = val[6]

    if not link then
        return format('%s guifg=%s guibg=%s guisp=%s gui=%s',
            val[1],
            val[2],
            val[3],
            val[4],
            val[5])
    else
        return format('link %s %s', val[1], link)
    end
end

apply_colors = function(scheme)
    vim.cmd(concat2s(':', concat(collect(map(function(val)
        return format('highlight! %s', as_str(val))
    end, ivals(scheme))), ' | ')))
end

apply_keys = function(scheme)
    each(function(desc)
        vim.keymap.set(desc[1], desc[2], desc[3], desc[4])
    end, ivals(scheme))
end

return {
    apply_colors = apply_colors,
    apply_keys   = apply_keys,
}

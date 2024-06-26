local type_lib        = require 'nd.lib.type'

local nvim_color_fn   = require 'nd.res.nvim.colors'
local nvim_key_fn     = require 'nd.res.nvim.keys'

local is_tab          = type_lib.is_tab

local is_color_ok     = nil
local is_key_ok       = nil

local get_bench_cases = nil
local get_test_cases  = nil


local opts = {
    sep    = '\n',
    step   = '    ',
    offset = '',
}

is_color_ok = function(x, _)
    return x and
        is_tab(x.palette) and
        is_tab(x.accent) and
        is_tab(x.highlight)
end

is_key_ok = function(x, _)
    return is_tab(x)
end

get_bench_cases = function()
    return {
        {
            name = 'color.nvim.fn()',
            opts = opts,
            args = {
                scheme = 'nd-even',
            },
            fn = nvim_color_fn,
        },
        {
            name = 'key.nvim.fn()',
            opts = opts,
            args = {
                scheme = 'nd-even',
                api = {
                    nvim = {},
                    telescope = {},
                    tree = {},
                    cmp = {},
                    snip = {},
                },
                leader = {
                    files    = ';',
                    lsp_goto = 'g',
                    lsp      = ' ',
                },
                opts = {},
            },
            fn = nvim_key_fn,
        },
    }
end

get_test_cases = function()
    return {
        {
            name = 'color.nvim.fn()',
            opts = opts,
            args = {
                scheme = 'nd-even',
            },
            res = {},
            fn = nvim_color_fn,
            is_ok = is_color_ok,
        },
        {
            name = 'color.nvim.fn()',
            opts = opts,
            args = {
                palette   = 'nd-even',
                accent    = 'nd-even',
                highlight = 'nd-even',
                special   = 'nd-even',
            },
            res = {},
            fn = nvim_color_fn,
            is_ok = is_color_ok,
        },
        {
            name = 'key.nvim.fn()',
            opts = opts,
            args = {
                scheme = 'nd-even',
                api = {
                    nvim = {},
                    telescope = {},
                    tree = {},
                    cmp = {},
                    snip = {},
                },
                leader = {
                    files    = ';',
                    lsp_goto = 'g',
                    lsp      = ' ',
                },
                opts = {},
            },
            res = {},
            fn = nvim_key_fn,
            is_ok = is_key_ok,
        },
    }
end

return {
    get_bench_cases = get_bench_cases,
    get_test_cases  = get_test_cases,
}

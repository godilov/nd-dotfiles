local type_lib   = require 'nd.lib.type'
local assert_lib = require 'nd.lib.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)

return function(config)
    local api    = config.api
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(api), 'api must be of type table')
    nd_assert(api.cmp, 'api.cmp must be of type value')
    nd_assert(api.snip, 'api.snip must be of type value')

    nd_assert(is_tab(leader), 'leader must be of type table')
    nd_assert(is_tab(opts) or not opts, 'opts must be of type table or nil')

    return function()
        local cmp  = api.cmp
        local snip = api.snip

        return {
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),

            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },

            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif snip.expand_or_jumpable() then
                    snip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif snip.jumpable(-1) then
                    snip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),

            ['<C-Space>'] = cmp.mapping.complete(),
        }
    end
end

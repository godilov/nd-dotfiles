local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.nvim.main.ext.cmp'

return function(config)
    local api    = config.api
    local leader = config.leader
    local opts   = config.opts

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(api.cmp, nd_err, 'fn(): api.cmp must be of type value')
    nd_assert(api.snip, nd_err, 'fn(): api.snip must be of type value')

    nd_assert(is_tab(leader), nd_err, 'fn(): leader must be of type table')
    nd_assert(is_tab(opts) or not opts, nd_err, 'fn(): opts must be of type table or nil')

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

local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.awesome.main.button.root'

return function(config)
    local api = config.api
    local mod = config.mod.button

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(mod), nd_err, 'fn(): mod.button must be of type table')

    local awful = api.awful

    nd_assert(awful, nd_err, 'fn(): api.awful must be of type value')

    return {
        { {}, mod.roller_up,   awful.tag.viewnext },
        { {}, mod.roller_down, awful.tag.viewprev },
    }
end

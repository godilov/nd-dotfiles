local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.awesome.main.button.tasklist'

return function(config)
    local api = config.api
    local mod = config.mod.button

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(mod), nd_err, 'fn(): mod.button must be of type table')

    return {
        { {}, mod.left, function(c)
            if c == client.focus then
                c.minimized = true
            else
                c.minimized = false

                c:emit_signal 'request::activate'
            end
        end, },
    }
end

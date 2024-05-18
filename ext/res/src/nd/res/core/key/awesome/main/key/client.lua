local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.awesome.main.key.client'

return function(config)
    local api   = config.api
    local mod   = config.mod.key
    local event = config.event

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(mod), nd_err, 'fn(): mod.key must be of type table')
    nd_assert(is_tab(event), nd_err, 'fn(): event must be of type table')

    local awful  = api.awful
    local client = api.client

    nd_assert(awful, nd_err, 'fn(): api.awful must be of type value')
    nd_assert(client, nd_err, 'fn(): api.client must be of type value')

    local screen_move = function(i)
        return function(c)
            c:move_to_screen(client.focus.screen.index + i)
        end
    end

    local tag_move = function(i)
        return function(c)
            local screen   = awful.screen.focused()
            local tags     = screen.tags

            local ind      = screen.selected_tags[#screen.selected_tags].index
            local ind_next = (ind + i + #tags - 1) % #tags + 1

            c:move_to_tag(tags[ind_next])

            awful.tag.viewidx(i)

            event.on_tag()
        end
    end

    return {
        { { mod.super, mod.shift }, 'j', screen_move(-1), {} },
        { { mod.super, mod.shift }, 'k', screen_move(1),  {} },
        { { mod.super, mod.alt },   'j', tag_move(-1),    {} },
        { { mod.super, mod.alt },   'k', tag_move(1),     {} },
        { { mod.super }, 'n', function(c)
            c.maximized = not c.maximized
            c:raise()
        end, {}, },
        { { mod.super }, 'm', function(c)
            c.minimized = not c.minimized
            c:lower()
        end, {}, },
    }
end

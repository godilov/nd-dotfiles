local type_lib   = require 'nd.lib.core.type'
local assert_lib = require 'nd.lib.core.assert'

local is_tab     = type_lib.is_tab

local nd_assert  = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err     = assert_lib.get_err_fn 'nd.res.core.key.awesome.main.key.root'


local event_fn = function(fn)
    return function(val)
        return fn(val)
    end
end

return function(config)
    local api   = config.api
    local mod   = config.mod.key
    local event = config.event

    nd_assert(is_tab(api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(mod), nd_err, 'fn(): mod.key must be of type table')
    nd_assert(is_tab(event), nd_err, 'fn(): event must be of type table')

    local awful   = api.awful
    local naughty = api.naughty
    local menubar = api.menubar
    local client  = api.client
    local media   = api.media

    nd_assert(awful, nd_err, 'fn(): api.awful must be of type value')
    nd_assert(naughty, nd_err, 'fn(): api.naughty must be of type value')
    nd_assert(menubar, nd_err, 'fn(): api.menubar must be of type value')
    nd_assert(client, nd_err, 'fn(): api.client must be of type value')
    nd_assert(media, nd_err, 'fn(): api.media must be of type value')

    return {
        { { mod.super }, 'F9',    awesome.restart,    {} },
        { { mod.super }, 'F12',   awesome.quit,       {} },
        { {},            'Print', media.screen.print, {} },
        { { mod.super }, '=', function()
            media.sound.add(nil, 10)

            media.sound.get_val(event_fn(event.on_sound))
        end, {}, },
        { { mod.super }, '-', function()
            media.sound.add(nil, -10)

            media.sound.get_val(event_fn(event.on_sound))
        end, {}, },
        { { mod.super }, '[', function()
            media.light.add(nil, 10)

            media.sound.get_val(event_fn(event.on_light))
        end, {}, },
        { { mod.super }, ']', function()
            media.light.add(nil, -10)

            media.sound.get_val(event_fn(event.on_light))
        end, {}, },
        { { mod.super },            'h', function() awful.client.focus.byidx(-1) end,    {} },
        { { mod.super },            'l', function() awful.client.focus.byidx(1) end,     {} },
        { { mod.super },            'j', function() awful.screen.focus_relative(-1) end, {} },
        { { mod.super },            'k', function() awful.screen.focus_relative(1) end,  {} },
        { { mod.super, mod.shift }, 'h', function() awful.client.swap.byidx(-1) end,     {} },
        { { mod.super, mod.shift }, 'l', function() awful.client.swap.byidx(1) end,      {} },
        -- { { mod.super, mod.shift }, 'j', {}, {}}, -- Defined by client
        -- { { mod.super, mod.shift }, 'k', {}, {}}, -- Defined by client

        { { mod.super, mod.ctrl }, 'h', function()
        end, {}, },
        { { mod.super, mod.ctrl }, 'l', function()
        end, {}, },
        { { mod.super, mod.ctrl }, 'j', function()
        end, {}, },
        { { mod.super, mod.ctrl }, 'k', function()
        end, {}, },

        -- { { mod.super }, 'n', {}, {}}, -- Defined by client
        -- { { mod.super }, 'm', {}, {}}, -- Defined by client
        { { mod.super }, ',', function()
            local c = awful.client.restore()

            if c then
                c:emit_signal 'request::activate'
            end
        end, {}, },
        { { mod.super, mod.alt }, 'h', function(...)
            event.on_tag()

            return awful.tag.viewprev(...)
        end, {}, },
        { { mod.super, mod.alt }, 'l', function(...)
            event.on_tag()

            return awful.tag.viewnext(...)
        end, {}, },
        -- { { mod.super, mod.alt }, 'j', {}, {}}, -- Defined by client
        -- { { mod.super, mod.alt }, 'k', {}, {}}, -- Defined by client

        { { mod.super, mod.crtl }, 'q', function()
            if client.focus then
                client.focus:kill()
            end
        end, {}, },
        { { mod.super }, mod.enter, function() awful.spawn 'alacritty' end, {} },
        { { mod.super }, mod.space, function() menubar.show() end,          {} },
        { { mod.super }, '`', function()
            for s in screen do
                s.wibar.visible = not s.wibar.visible
            end
        end, {}, },
    }
end

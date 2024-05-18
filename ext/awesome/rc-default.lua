local awful   = require 'awful'
local naughty = require 'naughty'

require 'awful.autofocus'
require 'awful.hotkeys_popup.keys'

if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors,
    }
end

do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        if in_error then return end

        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err),
        }

        in_error = false
    end)
end

client.connect_signal('manage', function(c)
    if  awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

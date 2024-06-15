local str_lib   = require 'nd.lib.str'

local event_lib = require 'nd.lib.event'

local pactl     = require 'nd.awesome.config.media.pactl'
local light     = require 'nd.awesome.config.media.light'

local concat2s  = str_lib.concat2s

local awesome   = awesome
local screen    = screen
local client    = client
local root      = root
local awful     = require 'awful'
local beautiful = require 'beautiful'
local gears     = require 'gears'
local wibox     = require 'wibox'
local naughty   = require 'naughty'
local menubar   = require 'menubar'

local date      = os.date

return {
    ['main'] = {
        scheme = 'main',
        mod = {
            key = {
                alt   = 'Mod1',
                ctrl  = 'Control',
                shift = 'Shift',
                super = 'Mod4',
                enter = 'Return',
                space = 'space',
            },
            button = {
                left        = 1,
                right       = 3,
                roller      = 2,
                roller_up   = 4,
                roller_down = 5,
                side_next   = 9,
                side_prev   = 8,
            },
        },
        api = {
            awesome   = awesome,
            screen    = screen,
            client    = client,
            root      = root,
            awful     = awful,
            beautiful = beautiful,
            gears     = gears,
            wibox     = wibox,
            naughty   = naughty,
            menubar   = menubar,
            media     = {
                sound = pactl,
                light = light,
                bluetooth = {
                    list = function()
                    end,
                },
                screen = {
                    print = function()
                        local path = concat2s('~/Pictures/Screenshots/', date '%Y-%m-%d_%H-%M-%S.png')

                        awful.spawn.with_shell(concat2s('shotgun -s ', path))

                        naughty.notify {
                            text = concat2s('Screenshot: ', path),
                        }
                    end,
                },
            },
        },
        event = {
            on_sound = function(val)
                event_lib.notify('key', 'sound', val)
            end,
            on_light = function(val)
                event_lib.notify('key', 'light', val)
            end,
            on_tag = function()
                event_lib.notify('key', 'tag')
            end,
        },
    },
}

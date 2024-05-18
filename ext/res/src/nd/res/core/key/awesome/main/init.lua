local type_lib           = require 'nd.lib.core.type'
local assert_lib         = require 'nd.lib.core.assert'

local is_tab             = type_lib.is_tab

local nd_assert          = assert_lib.get_fn(ND_RES_IS_DEBUG)
local nd_err             = assert_lib.get_err_fn 'nd.res.core.key.awesome.main'

local root_key_fn        = require 'nd.res.core.key.awesome.main.key.root'
local client_key_fn      = require 'nd.res.core.key.awesome.main.key.client'

local root_button_fn     = require 'nd.res.core.key.awesome.main.button.root'
local client_button_fn   = require 'nd.res.core.key.awesome.main.button.client'
local tasklist_button_fn = require 'nd.res.core.key.awesome.main.button.tasklist'
local taglist_button_fn  = require 'nd.res.core.key.awesome.main.button.taglist'

return function(config)
    nd_assert(is_tab(config), nd_err, 'fn(): config must be of type table')
    nd_assert(is_tab(config.api), nd_err, 'fn(): api must be of type table')
    nd_assert(is_tab(config.mod), nd_err, 'fn(): mod must be of type table')
    nd_assert(is_tab(config.event), nd_err, 'fn(): event must be of type table')

    return {
        key = {
            root   = root_key_fn(config),
            client = client_key_fn(config),
        },
        button = {
            root     = root_button_fn(config),
            client   = client_button_fn(config),
            tasklist = tasklist_button_fn(config),
            taglist  = taglist_button_fn(config),
        },
    }
end

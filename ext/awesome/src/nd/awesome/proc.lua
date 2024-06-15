local fn_lib     = require 'nd.lib.fn'
local str_lib    = require 'nd.lib.str'

local ivals      = fn_lib.ivals
local each       = fn_lib.each

local concat2s   = str_lib.concat2s
local concat3s   = str_lib.concat3s

local awful      = require 'awful'

local spawn      = awful.spawn
local easy_async = awful.spawn.easy_async


local unique  = nil
local uniques = nil


unique = function(prog)
    local cmd  = prog[1]
    local args = prog[2]

    easy_async(concat2s('pgrep ', cmd), function(_, _, _, code)
        if code ~= 0 then
            spawn(concat3s(cmd, ' ', args or ''))
        end
    end)
end

uniques = function(progs)
    each(unique, ivals(progs))
end

return {
    unique  = unique,
    uniques = uniques,
}

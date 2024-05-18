local fn_lib  = require 'nd.lib.core.fn'

local gears   = require 'gears'

local ivals   = fn_lib.ivals
local map     = fn_lib.map
local collect = fn_lib.collect

local unpack  = table.unpack

return function(t, fn)
    return gears.table.join(unpack(collect(map(function(elem)
        return fn(elem[1], elem[2], elem[3], elem[4], elem[5])
    end, ivals(t)))))
end

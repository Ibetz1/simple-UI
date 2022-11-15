local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

require(_PACKAGE .. "luaObjects")

love.graphics.setDefaultFilter("nearest", "nearest")

-- convert bool to int
function boolToInt(b)
    if b == true then return 1 end
    return 0
end

-- point in box check
function PBB(x, y, x1, y1, w1, h1)
    return x > x1 and x < x1 + w1 and y > y1 and y < y1 + h1
end

-- point in circle check
function PCC(x, y, x1, y1, r) 
    return ((x1 - x) ^ 2 + (y1 - y) ^ 2) ^ 0.5 < r
end

ui = {}
ui.map = require(_PACKAGE .. "map")()
ui.widget = require(_PACKAGE .. "widget")
ui.widgets = require(_PACKAGE .. "widgets")
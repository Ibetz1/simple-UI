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

-- snap coord to grid
function SNAPVAL(x, y, w, h)
    local tw, th = love.graphics.getWidth() / w, love.graphics.getHeight() / h
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    local tx, ty = math.ceil((x / sw) * tw) * w, math.ceil((y / sh) * th) * h
    return tx, ty
end

-- clamp function
function clamp(val, min, max)
    return math.min(math.max(val, min), max)
end

-- ui lib
ui = {}

-- ui cls
require(_PACKAGE .. "tools")
__scene = require(_PACKAGE .. "scene")
ui.widget = require(_PACKAGE .. "widget")
ui = table.merge(ui, require(_PACKAGE .. "widgets"))


ui.__scenes = {}
ui.__aliases = {}
ui.__scene = nil

-- ui backend

-- set scene alias (name)
ui.__aliasScene = function(i, name)
    ui.__aliases[name] = i
end

-- update a scene
ui.__update = function()
    if ui.__scene == nil then return end
    local dt = love.timer.getDelta()
    ui.__scenes[ui.__scene]:update(dt)
end

-- render a scene
ui.__draw = function()
    ui.logging:render()
    if ui.__scene == nil then return end
    ui.__scenes[ui.__scene]:draw()
end

-- sets scene for ui
ui.setScene = function(scene)
    local oscene = scene
    if type(scene) == "string" then
        scene = ui.__aliases[scene] or 1
    end
    ui.__scene = scene
    ui.logging.log("scene set to scene <" .. oscene .. ">", {1, 0, 1})
end
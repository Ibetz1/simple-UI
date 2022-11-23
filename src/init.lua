local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""

require(_PACKAGE .. "luaObjects")

love.graphics.setDefaultFilter("nearest", "nearest")

-- ui lib
ui = {}
local scenes = {}
ui.interface = love.graphics.newCanvas()

-- ui cls
require(_PACKAGE .. "tools")
require(_PACKAGE .. "aliases")
ui = table.add(require(_PACKAGE .. "widgets"), ui)

_scene_ = function(t)
    local scene = ui.__tags.container(t, true)
    table.insert(scenes, scene)
    return scene
end

local function updateScenes()
    ui.interface:renderTo(function()
        local dt = love.timer.getDelta()
        for i = 1, #scenes do
            local sc = ui.scenes[i]
            if sc.show then
                sc:updateChildren(dt)
                sc:renderChildren()
            end
        end
    end)
end
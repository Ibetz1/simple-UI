local scene = object:new()

function scene:init(objects)
    self.buffer = love.graphics.newCanvas()
    self.gridMap = love.graphics.newCanvas()
    self.widgets = {}

    self.ox = 0
    self.oy = 0

    self.showGrid = false
    self:setGridAlignment(1, 1)

    -- add objects
    for k, v in pairs(objects) do
        if type(v) == "table" and v.__type == "luaobject" then
            _G[k] = v
            self:addWidget(v)
        end
    end
    
    -- set scene reference
    self.__scRef = #ui.__scenes + 1
    ui.__scenes[self.__scRef] = self

    if objects.name then
        ui.__aliasScene(self.__scRef, objects.name)
    end
end

-- add widget to scene
function scene:addWidget(widget, layer)

    -- add widget
    table.insert(self.widgets, widget)
    widget.index = #self.widgets
    widget.map = self

    -- move to layer
    local layer = layer or widget.index
    if self.widgets[layer] and layer ~= widget.index then
        self:swapWidgets(widget.index, layer)
    end
end

-- sets scene grid alignment
function scene:setGridAlignment(w, h)
    self.gridSpacingX, self.gridSpacingY = w, h
    self.gridTileW, self.gridTileH = math.ceil(self.buffer:getWidth() / self.gridSpacingX), math.ceil(self.buffer:getHeight() / self.gridSpacingY)

    -- do alignment
    if not self.showGrid then return end

    self.gridMap:renderTo(function() 
        love.graphics.clear()
        love.graphics.setLineWidth(0.5)
        for x, y in iter(self.gridTileW, self.gridTileH) do
            local x, y = x - 1, y - 1
            love.graphics.rectangle("line", x * w, y * h, w, h)
        end
    end)
end

-- re align all widgets
function scene:alignWidgets()
    for i = 1, #self.widgets do
        self.widgets[i]:snapTile(self.gridSpacingX, self.gridSpacingY)
    end
end

-- swap widgets in layers
function scene:swapWidgets(i1, i2)
    self.widgets[i1].index, self.widgets[i2].index = self.widgets[i2].index, self.widgets[i1].index
    self.widgets[i1], self.widgets[i2] = self.widgets[i2], self.widgets[i1]
end

-- update all widgets
function scene:update()
    local dt = love.timer.getDelta()

    -- render buffer
    self.buffer:renderTo(function() 
        love.graphics.clear()

        -- render and update all widgets
        for i = #self.widgets, 1, -1 do
            local doRender = self.widgets[i]:onScreen(self.ox, self.oy)

            -- update and draw if renderable
            if doRender and self.widgets[i].show then
                self.widgets[i]:update(dt, self.ox, self.oy)
                self.widgets[i]:draw(self.ox, self.oy)
            end
        end
    end)
end

-- draw all widgets
function scene:draw()
    love.graphics.draw(self.buffer)

    if self.showGrid then
        love.graphics.draw(self.gridMap)
    end
end

ui.logging.log("UI >> scene object created", "notification")
return scene
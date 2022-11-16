local map = object:new()

function map:init()
    self.buffer = love.graphics.newCanvas()
    self.widgets = {}
    self.font = love.graphics.getFont()

    self.ox = 0
    self.oy = 0
end

-- add widget to map
function map:addWidget(widget, layer)

    -- add widget
    table.insert(self.widgets, widget)
    widget.index = #self.widgets
    widget.map   = self

    -- move to layer
    local layer = layer or widget.index
    if self.widgets[layer] and layer ~= widget.index then
        self:swapWidgets(widget.index, layer)
    end
end

-- swap widgets in layers
function map:swapWidgets(i1, i2)
    self.widgets[i1].index, self.widgets[i2].index = self.widgets[i2].index, self.widgets[i1].index
    self.widgets[i1], self.widgets[i2] = self.widgets[i2], self.widgets[i1]
end

-- update all widgets
function map:update(dt)
    -- render buffer
    self.buffer:renderTo(function() 
        love.graphics.clear()
        
        for i = #self.widgets, 1, -1 do

            self.widgets[i]:update(dt, self.ox, self.oy)
            self.widgets[i]:draw(self.ox, self.oy)

        end

    end)
end

-- draw all widgets
function map:draw()
    love.graphics.draw(self.buffer)
end

ui.logging.log("UI >> map object created", "notification")
return map
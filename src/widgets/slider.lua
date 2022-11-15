local slider = object:new(ui.widget)

function slider:init(properties)
    self:map(properties.layer)
    self:show()

    -- value properties
    self.scale = properties.scale or 1
    self.x = properties.x or 0
    self.y = properties.y or 0
    self.length = (properties.length or 100) * self.scale
    self.lineThickness = (properties.lineThickness or 3) * self.scale
    self.orientation = properties.orientation or "horizontal"
    self.boxw = self.length
    self.boxh = (properties.boxh or 3) * self.lineThickness

    self.colors = {
        textColor = properties.textColor or {0, 0, 0, 1},
        fill = {
            properties.fillColorIdle    or {1, 1, 1, 1},
            properties.fillColorHover   or {0.8, 0.8, 0.8, 1},
            properties.fillColorPressed or {0.5, 0.5, 0.5, 1},
        },
        line = {
            properties.lineColorIdle    or {0.5, 0.5, 0.5, 1},
            properties.lineColorHover   or {0.5, 0.5, 0.5, 1},
            properties.lineColorPressed or {1, 1, 1, 1}
        } 
    }

    -- info
    self.hover = false
    self.pressed = false
    self.excecuted = 0
    self.state = 1
    self.val = 0
end

function slider:getVal()
    return self.val
end

-- update slider
function slider:update(dt, ox, oy)
    local ox, oy = ox or 0, oy or 0
    local mx, my = love.mouse.getPosition()    

    local dist = 0

    -- vertical state check
    if self.orientation == "vertical" then
        dist = my - (self.y + oy)
        local cx, cy = self.x + ox, self.y + oy + self.val * self.boxw
        self.hover = PBB(mx, my, self.x + ox - self.boxh / 2, self.y + oy, self.boxh, self.boxw)
        self.hover = self.hover or PCC(mx, my, cx, cy, self.lineThickness)
    end

    -- horizontal state check
    if self.orientation == "horizontal" then
        dist = mx - (self.x + ox)
        local cx, cy = self.x + ox + self.boxw * self.val, self.y + oy
        self.hover = PBB(mx, my, self.x + ox, self.y + oy - self.boxh / 2, self.boxw, self.boxh)
        self.hover = self.hover or PCC(mx, my, cx, cy, self.lineThickness)
    end

    self.pressed = self.hover and love.mouse.isDown(1)
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    if self.pressed then
        self.val = math.floor(math.max(math.min(dist / self.boxw, 1), 0) * 1000) / 1000
    end
end

-- draw slider
function slider:draw(ox, oy)

    local ox, oy = ox or 0, oy or 0
    local x1, y1, x2, y2 = self.x + ox, self.y + oy, self.x + ox + self.length, self.y + oy
    local cx, cy = self.x + ox + self.boxw * self.val, self.y + oy

    if self.orientation == "vertical" then
        x2, y2 = self.x + ox, self.y + oy + self.length
        cx, cy = self.x + ox, self.y + oy + self.val * self.boxw
    end
    
    love.graphics.setLineWidth(self.lineThickness)
    
    love.graphics.setColor(self.colors.line[self.state])
    love.graphics.line(x1, y1, x2, y2)
    love.graphics.setLineWidth(1)

    love.graphics.setColor(self.colors.fill[self.state])
    love.graphics.circle("fill", cx, cy, self.lineThickness)
    love.graphics.setColor(1, 1, 1, 1)
end

print("UI >> Widgets >> slider object created")
return slider
local image = object:new(ui.widget)

function image:init(properties)

    self:map(properties.layer)
    self:show()

    -- texture properties
    self.image =   properties.image or love.graphics.newCanvas()
    self.mask =  properties.mask or {1, 1, 1, 1}

    -- image properties
    self.scale = properties.scale or 1
    self.x =     properties.x or 0
    self.y =     properties.y or 0
    self.angle = properties.angle or 0
    self.alignx = properties.alignx or "left"
    self.aligny = properties.aligny or "top"

    self.w = self.image:getWidth()  * self.scale
    self.h = self.image:getHeight() * self.scale
end

function image:draw(ox, oy)

    -- check for draw?
    local ox, oy = ox or 0, oy or 0
    if not self.show then return end
    if (self.x + self.w < 0 or self.x > love.graphics.getWidth()) then return end
    if (self.y + self.h < 0 or self.y > love.graphics.getWidth()) then return end

    -- render the image
    love.graphics.setColor(self.mask)
    local x, y = self.x, self.y

    -- set alignment
    if self.alignx == "center" then x = self.x - self.w / 2 end
    if self.aligny == "center" then y = self.y - self.h / 2 end
    if self.alignx == "right"  then x = self.x - self.w end
    if self.aligny == "bottom" then y = self.y - self.h end

    love.graphics.draw(self.image, x, y, self.angle, self.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

print("UI >> Widgets >> image object created")
return image
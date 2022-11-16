-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.widget)

function obj:init(properties)

    self:map(properties.layer)
    self:show()
    self:loadProperties(properties, env)

    -- custom properties
    self.image =   properties.image or love.graphics.newCanvas()
    self.w = self.image:getWidth()  * self.scale
    self.h = self.image:getHeight() * self.scale
    self.angle =  properties.angle or 0
end

function obj:draw(ox, oy)

    -- check for draw?
    local ox, oy = ox or 0, oy or 0
    if not self.show then return end
    if (self.x + self.w < 0 or self.x > love.graphics.getWidth()) then return end
    if (self.y + self.h < 0 or self.y > love.graphics.getWidth()) then return end

    -- render the image
    love.graphics.setColor(self.color.mask[1])
    local x, y = self.x, self.y

    -- set alignment
    if self.alignx == "center" then x = self.x - self.w / 2 end
    if self.aligny == "center" then y = self.y - self.h / 2 end
    if self.alignx == "right"  then x = self.x - self.w end
    if self.aligny == "bottom" then y = self.y - self.h end

    love.graphics.draw(self.image, x, y, self.angle, self.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> image object created", "notification")
return obj
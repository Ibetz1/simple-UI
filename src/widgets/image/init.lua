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
    self.w = self.image:getWidth()
    self.h = self.image:getHeight()
    self.angle =  properties.angle or 0
end

function obj:update(dt, ox, oy)
end


function obj:draw(ox, oy)
    -- render the image
    love.graphics.setColor(self.color.mask[1])
    local x, y = self.x, self.y
    local sw, sh = self.w * self.scale, self.h * self.scale

    -- set alignment
    if self.alignx == "center" then x = self.x - sw / 2 end
    if self.aligny == "center" then y = self.y - sh / 2 end
    if self.alignx == "right"  then x = self.x - sw end
    if self.aligny == "bottom" then y = self.y - sh end

    love.graphics.draw(self.image, x + ox, y + oy, self.angle, self.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> image object created", "notification")
return obj
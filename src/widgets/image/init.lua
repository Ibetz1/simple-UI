-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local obj = object:new(ui.__tags.container, env)

function obj:init(properties)
    self.show = true

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
    local x, y = self.x, self.y
    local sw, sh = self.w * self.scale, self.h * self.scale

    -- set alignment
    if self.alignx == ALIGN_CENTER then x = self.x - sw / 2 end
    if self.aligny == ALIGN_CENTER then y = self.y - sh / 2 end
    if self.alignx == ALIGN_RIGHT  then x = self.x - sw end
    if self.aligny == ALIGN_BOTTOM then y = self.y - sh end

    -- draw buffer with mask
    local alpha = ui.tools.getMaskOpacity(self.enabled, self.disabledOpacity, self.color.mask)
    love.graphics.setColor(self.color.mask[1], self.color.mask[2], self.color.mask[3], alpha)
    love.graphics.draw(self.image, x + ox, y + oy, self.angle, self.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> image object created", "notification")
return obj
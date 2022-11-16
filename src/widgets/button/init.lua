-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.widget)

function obj:init(properties)

    -- initiate widget
    self:map(properties.layer)
    self:show()
    self:loadProperties(properties, env)

    -- custom properties
    self.w = properties.w or ui.map.font:getWidth(self.text) * self.scale
    self.h = properties.h or ui.map.font:getHeight(self.text) * self.scale    
end

-- activates functions accordingly
function obj:applyFunctionality(mx, my)
    -- activate button onpress
    if self.pressed then
        self.onpress(mx, my, self)
        self.pressCount = self.pressCount + 1

    -- active button onreleased
    elseif self.pressCount > 0 and not self.pressed then
        self.onrelease(mx, my, self)
        self.pressCount = 0
    else
        self.pressCount = 0
    end

    -- activate button onhover
    if self.hover and self.pressCount <= 0 then
        self.onhover(mx, my, self)
        self.hoverCount = self.hoverCount + 1
    else
        self.hoverCount = 0
    end
end

-- updates button state
function obj:update(dt, ox, oy)
    local ox, oy = ox or 0, oy or 0
    local padx, pady = self.x + ox - self.padw, self.y + oy - self.padh
    local padw, padh = self.w + self.padw * 2, self.h + self.padh * 2

    -- check for update?
    if not self.show then return end
    if (padx + padw < 0 or padx > love.graphics.getWidth()) then return end
    if (pady + padh < 0 or pady > love.graphics.getWidth()) then return end

    -- update object
    local mx, my = love.mouse.getPosition()

    -- get button state
    self.hover = PBB(mx, my, padx, pady, padw, padh)
    self.pressed = self.hover and love.mouse.isDown(1)
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    self:applyFunctionality(mx, my)
end

-- draws button
function obj:draw(ox, oy)

    local padx, pady = self.x + ox - self.padw, self.y + oy - self.padh
    local padw, padh = self.w + self.padw * 2, self.h + self.padh * 2

    -- check for render?
    local ox, oy = ox or 0, oy or 0
    if not self.show then return end
    if (padx + padw < 0 or padx > love.graphics.getWidth()) then return end
    if (pady + padh < 0 or pady > love.graphics.getWidth()) then return end


    -- render button box
    love.graphics.setColor(self.color.fill[self.state])
    love.graphics.rectangle("fill", padx, pady, padw, padh)

    -- render outline
    love.graphics.setLineWidth(self.borderSize)

    love.graphics.setColor(self.color.border[self.state])
    love.graphics.rectangle("line", padx, pady, padw, padh)

    love.graphics.setLineWidth(1)

    -- render text
    love.graphics.setColor(self.color.text[self.state])

    do
        -- set alignment
        local x, y = self.x + ox, self.y + oy
        if self.alignx == "left"  then x = self.x + ox - self.padw + self.scale end
        if self.alignx == "right" then x = self.x + ox + self.padw - self.scale end

        love.graphics.print(self.text, x, y, 0, self.scale, self.scale)
    end

    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> button object created", "notification")
return obj
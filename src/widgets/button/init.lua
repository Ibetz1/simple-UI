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
    self.w = properties.w or ui.map.font:getWidth(self.text)
    self.h = properties.h or ui.map.font:getHeight(self.text)

    self.buffer = love.graphics.newCanvas(self.w + 2 * self.padw + self.borderSize * 2, 
                                          self.h + 2 * self.padh + self.borderSize * 2)
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
    local padx, pady = self.x + ox - self.padw , self.y + oy - self.padh
    local padw, padh = self.w + self.padw * 2 + (self.borderSize * self.scale), self.h + self.padh * 2 + (self.borderSize * self.scale)

    -- check for update?
    if not self.show then return end
    if (padx + padw < 0 or padx > love.graphics.getWidth()) then return end
    if (pady + padh < 0 or pady > love.graphics.getWidth()) then return end

    -- update object
    local mx, my = love.mouse.getPosition()

    -- get button state
    self.hover = PBB(mx, my, padx, pady, padw * self.scale, padh * self.scale)
    self.pressed = self.hover and love.mouse.isDown(1)
    local preState = self.state
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    if preState == self.state then return end

    self:applyFunctionality(mx, my)

    -- pre render
    self.buffer:renderTo(function()
        love.graphics.clear(0, 0, 0, 0)
        local px, py = self.borderSize, self.borderSize
        local pw, ph = padw - self.borderSize * self.scale, padh - self.borderSize * self.scale

        -- border
        love.graphics.setColor(self.color.border[self.state])
        love.graphics.rectangle("fill", 0, 0, padw, padh)

        -- inner
        love.graphics.setColor(self.color.fill[self.state])
        love.graphics.rectangle("fill", px, py, pw, ph)


        -- alignment
        if self.alignx == "center" then px = px + self.padw end
        if self.alignx == "right" then px = px + 2 * self.padw end
        if self.aligny == "center" then py = py + self.padh end
        if self.aligny == "bottom" then py = py + 2 * self.padh end

        -- text
        love.graphics.setColor(self.color.text[self.state])
        love.graphics.print(self.text, px, py, 0)

        love.graphics.setColor(1, 1, 1, 1)
    end)
end

-- draws button
function obj:draw(ox, oy)
    local ox, oy = ox or 0, oy or 0

    love.graphics.setColor(self.color.mask[self.state])

    love.graphics.draw(self.buffer, self.x - self.padw + ox, self.y - self.padh + oy, 0, self.scale, self.scale)

    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> button object created", "notification")
return obj
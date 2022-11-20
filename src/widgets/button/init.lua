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
    self.textW = properties.w or ui.map.font:getWidth(self.text)
    self.textH = properties.h or ui.map.font:getHeight(self.text)
    self.w = self.textW + (2 * self.padw) + (self.borderSize * 2)
    self.h = self.textH + (2 * self.padh) + (self.borderSize * 2)

    self.buffer = love.graphics.newCanvas(self.w, self.h)
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

function obj:preRender()
    self.buffer:renderTo(function()
        love.graphics.clear(0, 0, 0, 0)

        -- fill
        love.graphics.setColor(self.color.fill[self.state])
        love.graphics.rectangle("fill", self.borderSize / 2, self.borderSize / 2, 
                                        self.w - self.borderSize, self.h - self.borderSize, 
                                        self.cornerRadius, self.cornerRadius)

        -- border
        if self.borderSize > 0 then
            love.graphics.setLineWidth(self.borderSize)
            love.graphics.setColor(self.color.border[self.state])
            love.graphics.rectangle("line", self.borderSize / 2, self.borderSize / 2, 
                                            self.w - self.borderSize, self.h - self.borderSize, 
                                            self.cornerRadius, self.cornerRadius)
        end

        -- alignment x
        local px, py = self.borderSize, self.borderSize
        if self.alignx == "center" then px = (self.w - self.textW) / 2 end
        if self.alignx == "right"  then px = self.w - self.textW - self.borderSize end

        -- alignment y
        if self.aligny == "center" then py = (self.h - self.textH) / 2 end
        if self.aligny == "bottom" then py = self.h - self.textH - self.borderSize end

        -- text
        love.graphics.setColor(self.color.text[self.state])
        love.graphics.print(self.text, px, py, 0)

        love.graphics.setColor(1, 1, 1, 1)
    end)
end

-- updates button state
function obj:update(dt, ox, oy)
    -- check for update?
    local ox, oy = ox or 0, oy or 0

    -- references
    local scaledw, scaledh = self.w * self.scale, self.h * self.scale

    -- update object
    local mx, my = love.mouse.getPosition()

    -- get button state
    self.hover = PBB(mx, my, self.x + ox, self.y + oy, scaledw, scaledh)
    self.pressed = self.hover and love.mouse.isDown(1)
    local preState = self.state
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    if preState == self.state then return end

    self:applyFunctionality(mx, my)

    self:preRender()
end

-- draws button
function obj:draw(ox, oy)
    local ox, oy = ox or 0, oy or 0

    -- draw buffer with mask
    love.graphics.setColor(self.color.mask[self.state])
    love.graphics.draw(self.buffer, self.x + ox, self.y + oy, 0, self.scale, self.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> button object created", "notification")
return obj
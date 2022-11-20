-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.widget)

function obj:init(properties)
    self:map(properties.layer)
    self:show()
    self:loadProperties(properties, env)

    -- custom properties
    self.boxh = self.boxh * self.borderSize

    self.buffer = love.graphics.newCanvas(self.length + 2 * self.borderSize, self.boxh)
    self.w, self.h = self.buffer:getWidth(), self.buffer:getHeight()
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

    -- activate button onslide
    if self.slide then
        self.onslide(mx, my, self)
    end
end

function obj:preRender()
    self.buffer:renderTo(function()
        love.graphics.clear(0, 0, 0, 1)
        
        love.graphics.setLineWidth(self.borderSize) do

            -- track background
            love.graphics.setColor(self.color.border[self.state])
            love.graphics.line(self.borderSize, self.buffer:getHeight() / 2, 
                            self.buffer:getWidth() - self.borderSize, self.buffer:getHeight() / 2)

            -- progress bar
            love.graphics.setColor(self.color.accent[self.state])
            love.graphics.line(self.borderSize, self.buffer:getHeight() / 2, (self.length * self.val) + self.borderSize, self.buffer:getHeight() / 2)

            -- button
            love.graphics.setColor(self.color.fill[self.state])
            love.graphics.circle("fill", (self.length * self.val) + self.borderSize, self.buffer:getHeight() / 2, self.borderSize)

        love.graphics.setLineWidth(1) end
    end)
end

-- update slider
function obj:update(dt, ox, oy)

    -- mouse position
    local mx, my = love.mouse.getPosition()   

    -- get slider state
    self.hover = PBB(mx, my, self.x + ox - self.borderSize, self.y + oy, self.buffer:getWidth() * self.scale, self.buffer:getHeight() * self.scale)
    self.pressed = self.hover and love.mouse.isDown(1)
    local state = self.state
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    -- get slider value
    self.slide = false
    if self.state == 3 then
        local dist = mx - (self.x + ox + (self.borderSize) * self.scale)
        self.val = math.floor(math.max(math.min(dist / (self.length * self.scale), 1), 0) * 1000) / 1000
        self.slide = true  
    end

    self:applyFunctionality(mx, my)

    -- check if actually needs to re-render
    if state ~= -1 and self.state == 1 and state == self.state then return end
    self:preRender()
end

-- draw slider
function obj:draw(ox, oy)

    local ox, oy = ox or 0, oy or 0
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.buffer, self.x + ox, self.y + oy, 0, self.scale)
end


----------------------
-- object utilities --
----------------------

-- sets slider value
function obj:setVal(v) self.val = v end

-- returns value from slider
function obj:getVal() return self.val end

ui.logging.log("UI >> Widgets >> slider object created", "notification")
return obj
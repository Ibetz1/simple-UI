-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.widget)

function obj:init(properties)
    self:map(properties.layer)
    self:show()
    self:loadProperties(properties, env)

    -- custom properties
    self.boxw = self.length
    self.boxh = self.boxh * self.borderSize

    self.buffer = love.graphics.newCanvas(self.boxw + 2 * self.borderSize, self.boxh)
end

-- returns value from slider
function obj:getVal() return self.val end

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

-- update slider
function obj:update(dt, ox, oy)
    local ox, oy = ox or 0, oy or 0
    local mx, my = love.mouse.getPosition()    

    local dist = 0

    -- get slider state
    self.hover = PBB(mx, my, self.x + ox - self.borderSize, self.y + oy, self.buffer:getWidth() * self.scale, self.buffer:getHeight() * self.scale)
    self.pressed = self.hover and love.mouse.isDown(1)
    local state = self.state
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    -- update value
    if self.state == 3 then
        -- self.val = mx / ()
        self.slide = true
    else
        self.slide = false
    end

    self:applyFunctionality(mx, my)

    if state ~= -1 and self.state == 1 then return end

    -- pre render
    self.buffer:renderTo(function()
        love.graphics.clear(1, 1, 1, 1)
        
        love.graphics.setLineWidth(self.borderSize) do

            -- track background
            love.graphics.setColor(self.color.border[self.state])
            love.graphics.line(self.borderSize, self.buffer:getHeight() / 2, 
                            self.buffer:getWidth() - self.borderSize, self.buffer:getHeight() / 2)

            love.graphics.setColor(self.color.accent[self.state])
            love.graphics.line(self.borderSize, self.buffer:getHeight() / 2,
                            self.buffer:getWidth() * self.val - self.borderSize, self.buffer:getHeight() / 2)

        love.graphics.setLineWidth(1) end
    end)
end

-- draw slider
function obj:draw(ox, oy)

    -- swap orientation to horizontal
    local ox, oy = ox or 0, oy or 0
    local x1, y1, x2, y2 = self.x + ox, self.y + oy, self.x + ox + self.length, self.y + oy
    local px, py = x2 - self.length * (1 - self.val), y2
    local cx, cy = self.x + ox + self.boxw * self.val, self.y + oy

    -- swap orientation to vertical
    if self.orientation == "vertical" then
        x2, y2 = self.x + ox, self.y + oy + self.length
        cx, cy = self.x + ox, self.y + oy + self.val * self.boxw
        px, py = x2, self.y - self.length * (1 - self.val)
    end

    -- render track
    love.graphics.setLineWidth(self.borderSize)

        -- render track background
        love.graphics.setColor(self.color.border[self.state])
        -- love.graphics.line(x1, y1, x2, y2)

        -- render track foreground
        love.graphics.setColor(self.color.accent[self.state])
        -- love.graphics.line(x1, y1, px, py)

    love.graphics.setLineWidth(1)

    -- render button
    love.graphics.setColor(self.color.fill[self.state])
        -- love.graphics.circle("fill", cx, cy, self.borderSize)



    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(self.buffer, self.x + ox, self.y + oy, 0, self.scale)

    love.graphics.setColor(1, 0,0,1)
    love.graphics.circle("fill", self.x + (self.borderSize + self.length) * self.scale, self.y, 3)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> slider object created", "notification")
return obj
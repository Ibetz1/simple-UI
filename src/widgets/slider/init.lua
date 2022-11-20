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
        love.graphics.clear(self.color.background[self.state])
        
        -- draw track
        love.graphics.setLineWidth(self.borderSize) 
            local prog = (self.length * self.val) + self.borderSize
            -- track background
            love.graphics.setColor(self.color.border[self.state])
            love.graphics.line(self.borderSize, self.buffer:getHeight() / 2, 
                            self.buffer:getWidth() - self.borderSize, self.buffer:getHeight() / 2)

            -- progress bar
            love.graphics.setColor(self.color.accent[self.state])
            love.graphics.line(self.borderSize, self.buffer:getHeight() / 2, prog, self.buffer:getHeight() / 2)

        love.graphics.setLineWidth(1) 

        -- button
        if self.showButton then
            love.graphics.setColor(self.color.fill[self.state])
            love.graphics.circle("fill", prog, self.buffer:getHeight() / 2, self.borderSize)
        end
    end)
end

-- update slider
function obj:update(dt, ox, oy)

    -- mouse position
    local mx, my = love.mouse.getPosition()   

    -- get slider state horizontal

    
    -- get slider state vertical
    if self.orientation == ORIENT_VERTICAL then
        self.hover = PBB(mx, my, self.x + ox - self.borderSize, self.y + oy, 
                                 self.buffer:getHeight() * self.scale, 
                                 self.buffer:getWidth() * self.scale) 
    else
        self.hover = PBB(mx, my, self.x + ox - self.borderSize, self.y + oy, 
                                 self.buffer:getWidth() * self.scale, 
                                 self.buffer:getHeight() * self.scale)
    end



    self.pressed = self.hover and love.mouse.isDown(1)
    local state = self.state
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    -- get slider value
    self.slide = false
    if self.state == 3 then
        local dist

        -- value based orientation
        if self.orientation == ORIENT_VERTICAL then
            dist = my - (self.y + oy + (self.borderSize) * self.scale)
            self.val = 1 - math.floor(math.max(math.min(dist / (self.length * self.scale), 1), 0) * 1000) / 1000
        else
            dist = mx - (self.x + ox + (self.borderSize) * self.scale)
            self.val = math.floor(math.max(math.min(dist / (self.length * self.scale), 1), 0) * 1000) / 1000
        end

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

    -- flip and change angle for vertical orientation
    local angle, scale = 0, self.scale
    if self.orientation == ORIENT_VERTICAL then 
        angle = math.pi / 2
        scale = -self.scale
        oy = oy + self.w * self.scale
    end

    love.graphics.draw(self.buffer, self.x + ox, self.y + oy, angle, scale)
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
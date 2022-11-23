-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.__tags.container, env)

function obj:init(properties)

    -- initiate widget
    self.show = true

    -- custom properties
    self.val = false
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
        self.val = not self.val
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
        love.graphics.clear(self.color.background[self.state])

        -- fill
        love.graphics.setColor(self.color.fill[self.state])
        love.graphics.rectangle("fill", self.borderSize / 2, self.borderSize / 2, 
                                        self.w - self.borderSize, self.h - self.borderSize, 
                                        self.cornerRadius, self.cornerRadius)

        -- checked
        if self.val == true then
            love.graphics.setColor(self.color.accent[self.state])
            love.graphics.rectangle("fill", self.borderSize / 2, self.borderSize / 2, 
                                            self.w - self.borderSize, self.h - self.borderSize, 
                                            self.cornerRadius, self.cornerRadius)
        end

        -- border
        if self.borderSize > 0 then
            love.graphics.setLineWidth(self.borderSize)
            love.graphics.setColor(self.color.border[self.state])
            love.graphics.rectangle("line", self.borderSize / 2, self.borderSize / 2, 
                                            self.w - self.borderSize, self.h - self.borderSize, 
                                            self.cornerRadius, self.cornerRadius)
        end

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
    if self.enabled or self.state < 1 then
        self.hover = ui.tools.PBB(mx, my, self.x + ox, self.y + oy, scaledw, scaledh)
        self.pressed = self.hover and love.mouse.isDown(1)
        local preState = self.state
        self.state = ui.tools.boolToInt(self.hover) + ui.tools.boolToInt(self.pressed) + 1

        if preState == self.state then return end

        self:applyFunctionality(mx, my)
    end
    
    self:preRender()
end

-- draws button
function obj:draw(ox, oy)

    local ox, oy = ox or 0, oy or 0

    -- draw buffer with mask
    local alpha = ui.tools.getMaskOpacity(self.enabled, self.disabledOpacity, self.color.mask[self.state])
    love.graphics.setColor(self.color.mask[self.state][1], self.color.mask[self.state][2], self.color.mask[self.state][3], alpha)

    love.graphics.draw(self.buffer, self.x + ox, self.y + oy, 0, self.scale, self.scale)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> checkbox object created", "notification")
return obj
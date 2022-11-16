-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.widget)

function obj:init(properties)
    self:map(properties.layer)
    self:show()
    self:loadProperties(properties, env)

    -- custom properties
    self.length = (properties.length or 100) * self.scale
    self.orientation = properties.orientation or "horizontal"
    self.boxw = self.length
    self.boxh = (properties.boxh or 3) * self.borderSize
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

    -- vertical state check
    if self.orientation == "vertical" then
        dist = my - (self.y + oy)
        local cx, cy = self.x + ox, self.y + oy + self.val * self.boxw
        self.hover = PBB(mx, my, self.x + ox - self.boxh / 2, self.y + oy, self.boxh, self.boxw)
        self.hover = self.hover or PCC(mx, my, cx, cy, self.borderSize)
    end

    -- horizontal state check
    if self.orientation == "horizontal" then
        dist = mx - (self.x + ox)
        local cx, cy = self.x + ox + self.boxw * self.val, self.y + oy
        self.hover = PBB(mx, my, self.x + ox, self.y + oy - self.boxh / 2, self.boxw, self.boxh)
        self.hover = self.hover or PCC(mx, my, cx, cy, self.borderSize)
    end

    -- get slider state
    self.pressed = self.hover and love.mouse.isDown(1)
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1
    
    -- update value
    if self.pressed then
        local val = math.floor(math.max(math.min(dist / self.boxw, 1), 0) * 1000) / 1000
        self.slide = val ~= self.val
        self.val = val
    else
        self.slide = false
    end

    self:applyFunctionality(mx, my)
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
        love.graphics.line(x1, y1, x2, y2)

        -- render track foreground
        love.graphics.setColor(self.color.accent[self.state])
        love.graphics.line(x1, y1, px, py)

    love.graphics.setLineWidth(1)

    -- render button
    love.graphics.setColor(self.color.fill[self.state])
        love.graphics.circle("fill", cx, cy, self.borderSize)
    love.graphics.setColor(1, 1, 1, 1)
end

ui.logging.log("UI >> Widgets >> slider object created", "notification")
return obj
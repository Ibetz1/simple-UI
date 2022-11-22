local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.__tags.container)

function obj:init(properties)
    self:loadProperties(properties)
    self:loadChildren()
end

-- load properties onto widget
function obj:loadProperties(properties, environment)
    
    -- define property placeholders and apply formatting
    local properties = ui.tools.formatProperties(properties or {})
    local environment = ui.tools.formatProperties(environment or {})

    properties  = table.deepcopy(properties)
    env         = table.deepcopy(env)
    environment = table.deepcopy(environment)

    local environment = table.merge(environment, env)
    local mergedProperties = table.merge(properties, environment)

    -- initialize properties
    self.childrenTemp = {}
    self.children = {}
    for k, v in pairs(mergedProperties) do

        -- check for valid widget
        if type(v) == "table" and v.__tag and ui.__tags[v.__tag] then
            table.insert(self.childrenTemp, v)
        else
            self[k] = v
        end
    end

    -- scale properties accordingly
    self.padw = self.padw * self.scale
    self.padh = self.padh * self.scale
    self.borderSize = self.borderSize * self.scale

    -- initiation values
    self.propertiesLoaded = true
    self.childrenLoaded = false
end

-- post initiation (for children)
function obj:postInit(parent)
    if self.snap == true then self:snapTile() end
    self.parent = parent

    self.x, self.y = ui.tools.alignObject(self, parent)
end

-- load children into container
function obj:loadChildren()

    -- construct children
    for i = 1, #self.childrenTemp do
        local child = self.childrenTemp[i]
        local inst = ui.__tags[child.__tag](child)
        inst:postInit(self)
        table.insert(self.children, inst)
    end
    self.childrenTemp = nil
    
    -- merge rendering process for children
    local oupdate = self.update
    function self:update(...)
        oupdate(self, ...)
        self:updateChildren(...)
    end

    local odraw = self.draw
    function self:draw(...)
        odraw(self, ...)
        self:renderChildren(...)
    end

    self.childrenLoaded = true
end


-- check if widget off screen
function obj:onScreen(ox, oy)
    return ox + self.x + (self.w * self.scale) > 0 and
           oy + self.y + (self.h * self.scale) > 0 and
           ox + self.x < love.graphics.getWidth()  and
           oy + self.y < love.graphics.getHeight()
end

-- update all children
function obj:updateChildren(dt)
    for id, inst in pairs(self.children) do
        inst:update(dt, self.x, self.y)
    end
end

-- draw all children
function obj:renderChildren()
    for id, inst in pairs(self.children) do
        inst:draw(self.x, self.y)
    end
end

-- utilities
function obj:show() self.show = true end
function obj:hide() self.show = false end

-- sets group position
function obj:setPosition(x, y) self.x, self.y = x, y end

-- aligns widget to tile size
function obj:snapTile() self.x, self.y = ui.tools.snapCoords(self.x, self.y, self.snapx, self.snapy) end

ui.logging.log("UI >> container object created", "notification")
return obj
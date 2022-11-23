local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.__tags.container, env)

-- for initializing properties
function obj:preInit(properties)

    -- define property placeholders and apply formatting
    local properties  = ui.tools.formatProperties(properties or {})
    local environment = ui.tools.formatProperties(self.__env or {})

    local meta      = getmetatable(properties)
    if meta then meta = meta.__baseEnv end

    local environment = table.add(environment, env)
    local baseEnv = table.add(properties, environment)

    -- initialize properties
    self.childrenTemp = {}
    self.children = {}
    for k, v in pairs(baseEnv) do

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
end

-- for initializing children
function obj:postInit()

    -- construct children
    for i = 1, #self.childrenTemp do
        -- instasiate children relative to parent
        local child = self.childrenTemp[i]

        local inst = ui.__tags[child.__tag](child)
        inst.parent = self
        if inst.snap == true then inst:snapTile() end
        inst.x, inst.y = ui.tools.alignObject(inst)

        table.insert(self.children, inst)
    end
    self.childrenTemp = {}
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
        inst:updateChildren(dt)
    end
end

-- draw all children
function obj:renderChildren()
    for id, inst in pairs(self.children) do
        inst:draw(self.x, self.y)
        inst:renderChildren(dt)
    end
end

-- sets group position
function obj:setPosition(x, y) self.x, self.y = x, y end

-- aligns widget to tile size
function obj:snapTile() self.x, self.y = ui.tools.snapCoords(self.x, self.y, self.snapx, self.snapy) end

ui.logging.log("UI >> container object created", "notification")
return obj
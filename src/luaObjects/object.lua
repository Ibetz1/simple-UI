-- define class module
local object = {}
object.__index = object

-- function for instancing
function object:init() end
function object:update(dt) end
function object:draw() end

-- derives a new class
function object:new(parent)
    local cls = table.deepcopy(parent or {}, {})

    cls.__parent = parent
    cls.__index = cls

    setmetatable(cls, self)
    return cls
end

-- makes a new instance of class
function object:__call(...)
    local inst = setmetatable({
        id = uuid()
    }, self)

    inst:init(...)

    return inst
end

setmetatable(object, object)
return object
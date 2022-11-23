-- define class module
local object = {}
object.__index = object

-- function for instancing
function object:preInit() end
function object:init() end
function object:postInit() end
function object:update(dt) end
function object:draw() end

-- derives a new class
function object:new(parent, env)
    local env = env or {}
    local cls = table.deepcopy(parent or {}, {})

    cls.__env    = table.deepcopy(env or {}, {})
    cls.__type   = "luaobject"
    cls.__parent = parent
    cls.__index  = cls

    setmetatable(cls, self)
    return cls
end

-- makes a new instance of class
function object:__call(...)
    local inst = setmetatable({
        id = uuid()
    }, self)

    -- 3 phase initiation
    inst:preInit (...)
    inst:init    (...)
    inst:postInit(...)

    return inst
end

setmetatable(object, object)
return object
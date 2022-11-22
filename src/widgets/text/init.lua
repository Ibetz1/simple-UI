-- object and environment
local _PACKAGE = string.gsub(...,"%.","/") .. "/" or ""
local env = require(_PACKAGE .. "defaultEnv")
local obj = object:new(ui.__tags.container)

function obj:init(properties)
    self:loadProperties(properties, env)

    self:loadChildren()
end

function obj:update(dt, ox, oy)
end

function obj:draw(ox, oy)
end

ui.logging.log("UI >> Widgets >> text object created", "notification")
return obj
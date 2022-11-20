local env = ui.tools.newEnvironment {}
local widget = object:new()

function widget:map(layer)
    ui.map:addWidget(self, layer)
end

-- show / hide widget
function widget:show() self.show = true end
function widget:hide() self.show = false end

-- sets widget position
function widget:setPosition(x, y)
    self.x, self.y = x, y
end

-- aligns widget to tile size
function widget:alignTile(w, h)
    local tw = math.floor(love.graphics.getWidth() / w)
    local th = math.floor(love.graphics.getHeight() / h)

    self.x = math.ceil((self.x / love.graphics.getWidth()) * tw) * w
    self.y = math.ceil((self.y / love.graphics.getHeight()) * th) * h
end

-- check if widget off screen
function widget:onScreen(ox, oy)
    return ox + self.x + (self.w * self.scale) > 0 and
           oy + self.y + (self.h * self.scale) > 0 and
           ox + self.x < love.graphics.getWidth()  and
           oy + self.y < love.graphics.getHeight()
end

-- load properties onto widget
function widget:loadProperties(properties, environment)

    -- define property placeholders and apply formatting
    local properties = ui.tools.formatProperties(properties or {})
    local environment = table.merge(environment or {}, env)
    local mergedProperties = table.merge(properties, environment)

    -- add properties to widget
    for k, v in pairs(mergedProperties) do
        self[k] = v
    end

    -- scale properties accordingly
    self.padw = self.padw * self.scale
    self.padh = self.padh * self.scale
    self.borderSize = self.borderSize * self.scale
end

-- focus widget on map
function widget:focus(index)
    local index = index or 1

    ui.map:swapWidgets(index, self.index)
end

ui.logging.log("UI >> widget object created", "notification")
return widget
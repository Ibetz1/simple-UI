local env = ui.tools.newEnvironment {}
local widget = object:new()

function widget:map(layer)
    ui.map:addWidget(self, layer)
end

-- show / hide widget
function widget:show() self.show = true end
function widget:hide() self.show = false end

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

    -- swap index

    -- swap draw order
    ui.map:swapWidgets(index, self.index)
end

ui.logging.log("UI >> widget object created", "notification")
return widget
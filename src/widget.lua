local widget = object:new()

function widget:map(layer)
    ui.map:addWidget(self, layer)
end

-- show / hide widget
function widget:show() self.show = true end
function widget:hide() self.show = false end

-- focus widget on map
function widget:focus(index)
    local index = index or 1

    -- swap index

    -- swap draw order
    ui.map:swapWidgets(index, self.index)
end

print("UI >> widget object created")
return widget
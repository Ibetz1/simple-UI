require("src")

local function pressed(x, y, b)
    ui.logging.log("pressed!")
end

local s1 = ui.widgets.slider {
    x = 50,
    y = 60,
    scale = 2,
    borderSize = 2,
    length = 120,
}

local s2 = ui.widgets.slider {
    x = 50,
    y = 81,
    scale = 2,
    borderSize = 2,
    length = 120,
}

local b1 = ui.widgets.button {
    text = "button 1",
    scale = 2,
    x = 50,
    y = 120,
    padw = 3,
    padh = 2,
    borderSize = 1,
    cornerRadius = 5
}

local b2 = ui.widgets.button {
    text = "Button 2",
    scale = 2,
    x = 200,
    y = 120,
    padw = 2,
    padh = 2,
    borderSize = 0
}

ui.map:setGridAlignment(8, 8)
ui.map:alignWidgets()

function love.update(dt)
    ui.map:update(dt)
end

function love.draw()
    ui.map:draw()
    ui.logging:render()
end

function love.keyreleased(key)
    if (key == "l") then
        ui.logging.toggle()
    end
end
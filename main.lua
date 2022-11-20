require("src")

local function pressed(x, y, b)
    ui.logging.log("pressed!")
end

local buf = love.graphics.newCanvas(20, 20)
buf:renderTo(function() 
    love.graphics.clear(1, 1, 1, 1)
end)

local i1 = ui.widgets.image {
    x = 400,
    y = 20,
    image = buf
}

local s1 = ui.widgets.slider {
    x = 50,
    y = 60,
    scale = 2,
    borderSize = 4,
    length = 120
}

local b2 = ui.widgets.button {
    text = "Button 2",
    scale = 3,
    x = 16,
    y = 200,
    padw = 2,
    padh = 2,
    borderSize = 0
}

local b1 = ui.widgets.button {
    text = "button 1",
    scale = 5,
    x = 16,
    y = 300,
    padw = 3,
    padh = 2,
    borderSize = 1,
    cornerRadius = 5
}

ui.map:setAlignment(16, 16)
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
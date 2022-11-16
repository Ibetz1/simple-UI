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
    image = buf,
    -- maskColor = {1, 0, 0, 1}
}

local s1 = ui.widgets.slider {
    x = 50,
    y = 30,
    scale = 2,
    borderSize = 8,
    length = 120
}

local b2 = ui.widgets.button {
    text = "button 2",
    scale = 2,
    x = 150,
    y = 200,
    padw = 5,
    padh = 5,
    borderSize = 2,
    -- borderColorPressed = {1, 0, 0, 0}
    borderColorIdle = {1, 0, 0, 0}
}

local b1 = ui.widgets.button {
    text = "button 1",
    scale = 2,
    x = 50,
    y = 300,
    padw = 5,
    padh = 5,
    borderSize = 2,
}

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
require("src")

local function pressed(x, y, b)
    print("pressed!")
end


local buf = love.graphics.newCanvas(20, 20)
buf:renderTo(function() 
    love.graphics.clear(1, 1, 1, 1)
end)

local s1 = ui.widgets.slider {
    x = 50,
    y = 30,
    scale = 2,
    lineThickness = 8,
    length = 120,
    -- orientation = "vertical"
}

local b2 = ui.widgets.button {
    text = "button 2",
    scale = 2,
    x = 150,
    y = 200,
    padw = 5,
    padh = 5,
    borderSize = 2,
    textAlign = "center",
    textColor = {0, 1, 0, 1}
}

local b1 = ui.widgets.button {
    text = "button 1",
    scale = 2,
    x = 50,
    y = 300,
    padw = 5,
    padh = 5,
    borderSize = 2,
    textAlign = "center",
    textColor = {1, 0, 0, 1}
}

function love.update(dt)
    ui.map:update(dt)
end

function love.draw()
    ui.map:draw()
end
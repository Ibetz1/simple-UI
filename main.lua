require("src")

local function pressed(x, y, b)
    ui.logging.log("pressed!")
end

__scene {
    name = "scene1",

    c1 = ui.checkBox {
        x = 500,
        y = 60,
        cornerRadius = 10,
        borderSize = 3,
    },
    
    s1 = ui.slider {
        x = 50,
        y = 60,
        scale = 2,
        borderSize = 2,
        length = 120,
    },
    
    s2 = ui.slider {
        x = 50,
        y = 81,
        scale = 2,
        borderSize = 2,
        length = 120,
    },
    
    b1 = ui.button {
        text = "button 1",
        scale = 2,
        x = 50,
        y = 120,
        padw = 3,
        padh = 2,
        borderSize = 1,
        cornerRadius = 5
    },
    
    b2 = ui.button {
        text = "Button 2",
        scale = 2,
        x = 200,
        y = 120,
        padw = 2,
        padh = 2,
        borderSize = 0
    }
}

ui.setScene("scene1")

function love.update(dt)
    ui.__update()
end

function love.draw()
    ui.__draw()
end

function love.keyreleased(key)
    if (key == "l") then
        ui.logging.toggle()
    end
end
require("src")

local function pressed(x, y, b)
    ui.logging.log("pressed!")
end

local function toggle(x, y, b)
    b.parent.enabled = b.val
end

local slider = ui.slider {
    x = 50,
    y = 20,
    scale = 3,
    borderSize = 2,
    length = 120,
    snap = false,
    box = ui.checkBox {
        scale = 2,
        cornerRadius = 10,
        borderSize = 1,
        snap = true,
        onpress = toggle,
        x = ALIGN_LEFT,
        y = ALIGN_CENTER,
        offx = 5,
        alignMode = ALIGN_OUTSIDE,
        snap = false
    }    
}

local button = ui.button {
    text = "button 1",
    scale = 2,
    padw = 3,
    padh = 2,
    borderSize = 1,
    cornerRadius = 5,
    snap = false,
    box = ui.checkBox {
        scale = 2,
        cornerRadius = 10,
        borderSize = 1,
        snap = true,
        onpress = toggle,
        x = ALIGN_LEFT,
        y = ALIGN_CENTER,
        offx = 5,
        alignMode = ALIGN_OUTSIDE,
        snap = false
    } 
}

local g = ui.__tags.container {
    snapx = 8,
    snapy = 8,
    s1 = slider,
    s2 = slider { y = 70 },
    b1 = button { x = 50, y = 130 },
    b2 = button { x = 50, y = 190, text = "button 2"}
}


function love.update(dt)
    g:updateChildren(dt)
end

function love.draw()
    g:renderChildren()
    ui.logging:render()
end

function love.keyreleased(key)
    if (key == "l") then
        ui.logging.toggle()
    end
end
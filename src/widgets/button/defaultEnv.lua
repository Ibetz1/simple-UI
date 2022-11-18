return {
    hover = false,
    hoverCount = 0,
    pressed = false,
    pressCount = 0,
    state = -1,

    onhover = function(x, y, b)
        if b.hoverCount > 0 then return end
        ui.logging.log("button hovered!")
    end,

    onpress = function(x, y, b)
        if b.pressCount > 0 then return end
        ui.logging.log("button pressed!")
    end,

    onrelease = function(x, y, b)
        ui.logging.log("button released!")
    end
}
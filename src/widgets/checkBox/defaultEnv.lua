return {
    hover = false,
    hoverCount = 0,
    pressed = false,
    pressCount = 0,
    state = -1,
    cornerRadius = 0,
    w = 32, h = 32,

    accentColorIdle = rgba {0.2, 0.2, 0.2, 1},
    accentColorHover = rgba {0.2, 0.2, 0.2, 1},
    accentColorPressed = rgba {0.2, 0.2, 0.2, 1},

    onhover = function(x, y, b)
        if b.hoverCount > 0 then return end
        ui.logging.log("check box hovered!")
    end,

    onpress = function(x, y, b)
        if b.pressCount > 0 then return end
        ui.logging.log("check box pressed!")
    end,

    onrelease = function(x, y, b)
        ui.logging.log("check box released!")
    end
}
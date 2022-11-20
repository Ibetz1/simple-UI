return {
    hover = false,
    pressed = false,
    slide = false,
    pressCount = 0,
    hoverCount = 0,
    state = -1,
    val = 0,
    boxh = 3,
    orientation = ORIENT_HORIZONTAL,
    length = 100,

    showValue = true,
    showButton = true,

    onpress = function(x, y, s)
        if s.pressCount > 0 then return end
        ui.logging.log("slider pressed!")
    end,

    onhover = function(x, y, s)
        if s.hoverCount > 0 then return end
        ui.logging.log("slider hovered!")
    end,

    onslide = function(x, y, s)
        ui.logging.log("slider slid! new value is: " .. s.val)
    end,

    onrelease = function(x, y, s)
        ui.logging.log("slider released!")
    end
}
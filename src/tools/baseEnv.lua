-- default map environment, placeholder variables for all widgets --
--------------------------------------------------------------------


return {

    -- constructor parameters
    map = nil,

    -- default colors
    color = {
        text = {
            {0, 0, 0, 1},
            {0, 0, 0, 1},
            {0, 0, 0, 1}
        },
        mask = {
            {1, 1, 1, 1},
            {1, 1, 1, 1},
            {1, 1, 1, 1}
        },
        fill = {
            {1, 1, 1, 1},       -- idle
            {0.8, 0.8, 0.8, 1}, -- hover
            {0.5, 0.5, 0.5, 1}  -- pressed
        },
        border = {
            {0.5, 0.5, 0.5, 1},   -- idle
            {0.5, 0.5, 0.5, 1},   -- hover
            {0.25, 0.25, 0.25, 1} -- pressed
        },
        accent = {
            {1, 1, 1, 0.5}, -- idle
            {1, 1, 1, 0.5}, -- hover
            {1, 1, 1, 0.5}, -- pressed
        },
        background = {
            {0, 0, 0, 0},
            {0, 0, 0, 0},
            {0, 0, 0, 0}
        }
    },

    -- default scalars
    x = 0, y = 0,
    w = 0, h = 0,
    padw = 0, padh = 0,
    borderSize = 1,
    scale = 1,

    -- default alignment
    alignx = ALIGN_CENTER, aligny = ALIGN_CENTER,

    -- default values
    show = true,
    val = 0,
    text = "text",
}
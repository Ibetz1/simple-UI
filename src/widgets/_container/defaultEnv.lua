-- default map environment, placeholder variables for all widgets --
--------------------------------------------------------------------


return {

    -- constructor parameters
    map = nil,

    -- default colors
    disabledOpacity = 0.25,
    color = {
        text = {
            rgba {0, 0, 0, 1},
            rgba {0, 0, 0, 1},
            rgba {0, 0, 0, 1}
        },
        mask = {
            rgba {1, 1, 1, 1},
            rgba {1, 1, 1, 1},
            rgba {1, 1, 1, 1}
        },
        fill = {
            rgba {1, 1, 1, 1},       -- idle
            rgba {0.8, 0.8, 0.8, 1}, -- hover
            rgba {0.5, 0.5, 0.5, 1}  -- pressed
        },
        border = {
            rgba {0.5, 0.5, 0.5, 1},   -- idle
            rgba {0.5, 0.5, 0.5, 1},   -- hover
            rgba {0.25, 0.25, 0.25, 1} -- pressed
        },
        accent = {
            rgba {1, 1, 1, 0.5}, -- idle
            rgba {1, 1, 1, 0.5}, -- hover
            rgba {1, 1, 1, 0.5}, -- pressed
        },

        background = {
            rgba {0, 0, 0, 0},
            rgba {0, 0, 0, 0},
            rgba {0, 0, 0, 0}
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
    alignMode = ALIGN_OUTSIDE,
    snapx = 8, snapy = 8,
    offx = 0, offy = 0,

    -- default values
    show = true,
    enabled = true,
    val = 0,
    text = "text"
}
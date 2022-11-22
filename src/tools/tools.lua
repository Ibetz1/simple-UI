-- access colors via

-- [text]
-- textColorIdle = mode {color}
-- textColorHover = mode {color}
-- textColorPressed = mode {color}

-- [mask]
-- maskColorIdle = mode {color}
-- maskColorHover = mode {color}
-- maskColorPressed = mode {color}

-- [fill]
-- fillColorIdle = mode {color}
-- fillColorHover = mode {color}
-- fillColorPressed = mode {color}

-- [border]
-- borderColorIdle = mode {color}
-- borderColorHover = mode {color}
-- borderColorPressed = mode {color}

-- [accent]
-- accentColorIdle = mode {color}
-- accentColorHover = mode {color}
-- accentColorPressed = mode {color}

-- rgb color mode
function rgba(t) return t end
function hsva(t)
    local h, s, v, a = t[1], t[2], t[3], t[4]

    local k1 = v * (1 - s)
    local k2 = v - k1

    local r = k1 + k2 * clamp(3 * math.abs( ((( h - 000) / 180) % 2)- 1 ) - 1, 0, 1)
    local g = k1 + k2 * clamp(3 * math.abs( ((( h - 120) / 180) % 2)- 1 ) - 1, 0, 1)
    local b = k1 + k2 * clamp(3 * math.abs( ((( h - 240) / 180) % 2)- 1 ) - 1, 0, 1)
    return {r, g, b, a}
end

-- format property aliasing
function ui.tools.formatProperties(properties)

    -- format color properties
    properties.color = {
        text = {},
        mask = {},
        fill = {}, 
        border = {}, 
        accent = {}
    }

    -- reformat color indexing
    for i = 1, 3 do
        local ext = ""
        if i == 1 then ext = "Idle"    end
        if i == 2 then ext = "Hover"   end
        if i == 3 then ext = "Pressed" end

        -- translate aliasing
        properties.color.text[i]   = properties["textColor" .. ext]
        properties.color.mask[i]   = properties["maskColor" .. ext]
        properties.color.fill[i]   = properties["fillColor"  .. ext]
        properties.color.border[i] = properties["borderColor".. ext]
        properties.color.accent[i] = properties["accentColor".. ext]

        -- remove aliasing
        properties["text".. ext] = nil
        properties["mask".. ext] = nil
        properties["fill"  .. ext] = nil
        properties["border".. ext] = nil
        properties["accent".. ext] = nil

    end

    return properties
end

-- generate a new environment with modified values
function ui.tools.newEnvironment(menv, denv)
    local env = table.merge(menv or {}, denv or ui.tools.baseEnv)
    return env
end
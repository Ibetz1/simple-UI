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

-- align an objects coords with its parents
function ui.tools.alignObject(obj, parent)
    local x, y = obj.x, obj.y
    local pw, ph = parent.w * parent.scale, parent.h * parent.scale
    local ow, oh = obj.w * obj.scale, obj.h * obj.scale

    -- assert alignmode
    if obj.alignMode ~= ALIGN_OUTSIDE and obj.alignMode ~= ALIGN_OUTSIDE then object.alignMode = parent.alignMode end

    -- center alignment
    if obj.x == ALIGN_CENTER then x = (pw / 2) - (ph / 2) + obj.offx end
    if obj.y == ALIGN_CENTER then y = (ph / 2) - (oh / 2) + obj.offy end

    -- bottom alignment
    if obj.y == ALIGN_BOTTOM then
        if obj.alignMode == ALIGN_OUTSIDE then y = ph      end
        if obj.alignMode == ALIGN_INSIDE  then y = ph - oh end
        y = y + obj.offy
    end

    -- top alignment
    if obj.y == ALIGN_TOP then
        if obj.alignMode == ALIGN_OUTSIDE then y = -oh end
        if obj.alignMode == ALIGN_INSIDE  then y = 0   end
        y = y - obj.offy
    end

    -- left alignment
    if obj.x == ALIGN_LEFT then
        if obj.alignMode == ALIGN_OUTSIDE then x = -ow end
        if obj.alignMode == ALIGN_INSIDE  then x = 0   end
        x = x - obj.offx
    end

    -- right alignment
    if obj.x == ALIGN_RIGHT then
        if obj.alignMode == ALIGN_OUTSIDE then x = pw      end
        if obj.alignMode == ALIGN_INSIDE  then x = pw - ow end
        x = x + obj.offx
    end

    return x, y
end

-- convert bool to int
function ui.tools.boolToInt(b)
    if b == true then return 1 end
    return 0
end

-- point in box check
function ui.tools.PBB(x, y, x1, y1, w1, h1)
    return x > x1 and x < x1 + w1 and y > y1 and y < y1 + h1
end

-- point in circle check
function ui.tools.PCC(x, y, x1, y1, r) 
    return ((x1 - x) ^ 2 + (y1 - y) ^ 2) ^ 0.5 < r
end

-- snap coord to grid
function ui.tools.snapCoords(x, y, w, h)
    local tw, th = love.graphics.getWidth() / w, love.graphics.getHeight() / h
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    local tx, ty = math.ceil((x / sw) * tw) * w, math.ceil((y / sh) * th) * h
    return tx, ty
end

-- tags a table for instansiation
function ui.tools.tagTable(tag)
    return function(p)
        p.__tag = tag

        function p:__call(t)
            local temp = table.merge(t, self)
            return temp
        end

        setmetatable(p, p)

        return p 
    end
end

-- gets opacity of object mask
function ui.tools.getMaskOpacity(enabled, opacity, mask)
    local _, _, _, a = unpack(mask)

    if enabled then
        return a
    end

    return opacity
end

-- math.clamp function
function math.clamp(val, min, max)
    return math.min(math.max(val, min), max)
end

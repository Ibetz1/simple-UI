-- red green blue and alpha
function rgba(t) return {t[1], t[2], t[3], t[4] or 1} end

-- red green blue
function rgb(t)  return rgba {t[1], t[2], t[3]} end

-- hue saturation value and alpha
function hsva(t)
    local h, s, v, a = t[1], t[2], t[3], t[4]

    local k1 = v * (1 - s)
    local k2 = v - k1

    local r = k1 + k2 * clamp(3 * math.abs( ((( h - 000) / 180) % 2)- 1 ) - 1, 0, 1)
    local g = k1 + k2 * clamp(3 * math.abs( ((( h - 120) / 180) % 2)- 1 ) - 1, 0, 1)
    local b = k1 + k2 * clamp(3 * math.abs( ((( h - 240) / 180) % 2)- 1 ) - 1, 0, 1)
    return {r, g, b, a}
end

-- hue saturation value
function hsv(t)
    return hsva({t[1], t[2], t[3], 1})
end
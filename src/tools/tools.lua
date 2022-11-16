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
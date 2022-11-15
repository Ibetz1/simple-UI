local button = object:new(ui.widget)

function button:init(properties)
    local properties = properties or {}
    
    -- initiate widget
    self:map(properties.layer)
    self:show()

    -- text and alignment
    self.text = properties.text or ""
    self.textAlign = properties.textAlign or "center"

    -- position and size
    self.scale =      properties.scale or 1
    self.x =          properties.x or 0
    self.y =          properties.y or 0
    self.padw =       (properties.padw or 0) * self.scale
    self.padh =       (properties.padh or 0) * self.scale
    self.w =          properties.w or ui.map.font:getWidth(self.text) * self.scale
    self.h =          properties.h or ui.map.font:getHeight(self.text) * self.scale
    self.borderSize = (properties.borderSize or 1) * self.scale

    -- coloring
    self.colors = {
        textColor   = properties.textColor or {0, 0, 0, 1},
        fill = {
            properties.fillColorIdle    or {1, 1, 1, 1},
            properties.fillColorHover   or {0.8, 0.8, 0.8, 1},
            properties.fillColorPressed or {0.5, 0.5, 0.5, 1},
        },
        border = {
            properties.borderColorIdle    or {0.5, 0.5, 0.5, 1},
            properties.borderColorHover   or {0.5, 0.5, 0.5, 1},
            properties.borderColorPressed or {1, 1, 1, 1}
        }
    }

    -- info
    self.hover = false
    self.pressed = false
    self.excecuted = 0
    self.state = 1

    -- define functionality
    self.func = properties.func or function(x, y, b)
        if b.excecuted > 0 then return end

        print("button " .. b.id .. " >> pressed {" .. x .. ", " .. y .. "}")
    end
end

function button:update(dt, ox, oy)
    local ox, oy = ox or 0, oy or 0
    local padx, pady = self.x + ox - self.padw, self.y + oy - self.padh
    local padw, padh = self.w + self.padw * 2, self.h + self.padh * 2

    -- check for update?
    if not self.show then return end
    if (padx + padw < 0 or padx > love.graphics.getWidth()) then return end
    if (pady + padh < 0 or pady > love.graphics.getWidth()) then return end


    -- update object
    local mx, my = love.mouse.getPosition()

    -- get button state
    self.hover = PBB(mx, my, padx, pady, padw, padh)
    self.pressed = self.hover and love.mouse.isDown(1)
    self.state = boolToInt(self.hover) + boolToInt(self.pressed) + 1

    -- activate button
    if self.pressed then
        self.func(mx, my, self)
        self.excecuted = self.excecuted + 1
    else
        self.excecuted = 0
    end
end

function button:draw(ox, oy)

    local padx, pady = self.x + ox - self.padw, self.y + oy - self.padh
    local padw, padh = self.w + self.padw * 2, self.h + self.padh * 2

    -- check for render?
    local ox, oy = ox or 0, oy or 0
    if not self.show then return end
    if (padx + padw < 0 or padx > love.graphics.getWidth()) then return end
    if (pady + padh < 0 or pady > love.graphics.getWidth()) then return end


    -- render button box
    love.graphics.setColor(self.colors.fill[self.state])
    love.graphics.rectangle("fill", padx, pady, padw, padh)

    -- render outline
    love.graphics.setLineWidth(self.borderSize)

    love.graphics.setColor(self.colors.border[self.state])
    love.graphics.rectangle("line", padx, pady, padw, padh)

    love.graphics.setLineWidth(1)

    -- render text
    love.graphics.setColor(self.colors.textColor)

    do
        -- set alignment
        local x, y = self.x + ox, self.y + oy
        if self.textAlign == "left"  then x, y = self.x + ox - self.padw + self.scale, self.y + oy end
        if self.textAlign == "right" then x, y = self.x + ox + self.padw - self.scale, self.y + oy end

        love.graphics.print(self.text, x, y, 0, self.scale, self.scale)
    end

    love.graphics.setColor(1, 1, 1, 1)
end

print("UI >> Widgets >> button object created")
return button
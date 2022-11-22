-- ui logging utility --
------------------------

UI_LOGGING_LINECOUNT = 10
UI_LOGGING_FONT = love.graphics.getFont()
UI_LOGGING_BACKGROUND = {0.2, 0.2, 0.2, 0.5}

ui.logging = {
    -- generate log box
    enabled = false,
    logBox = love.graphics.newCanvas(love.graphics.getWidth(), UI_LOGGING_LINECOUNT * UI_LOGGING_FONT:getHeight("ABCDEFGHIJKLMNOPQRSTUVWXYZ")),
    logs = {}
}

local logDisableTimer = 1 - ui.tools.boolToInt(ui.logging.enabled) + 0.0001
local logTimerMax = 1

-- log a message
function ui.logging.log(message, t)
    table.insert(ui.logging.logs, {message = message, type = t or "message"})
    if (#ui.logging.logs > UI_LOGGING_LINECOUNT) then
        table.remove(ui.logging.logs, 1)
    end
end

-- toggle logging
function ui.logging.toggle()
    ui.logging.enabled = not ui.logging.enabled
    
    if ui.logging.enabled then
        ui.logging.log("logging enabled", {0, 1, 0, 1})
    else
        ui.logging.log("logging disabled", {1, 0, 0, 1})
    end
end

-- render log text
function ui.logging:render()

    -- show or hide logging
    local dt = love.timer.getDelta()
    if not ui.logging.enabled then 

        -- show/hide on timer
        if logDisableTimer > logTimerMax then
            return
        else
            logDisableTimer = logDisableTimer + dt
        end

    else
        logDisableTimer = logDisableTimer - dt
    end

    logDisableTimer = math.max(math.min(logDisableTimer, 1), 0)

    -- render log box
    self.logBox:renderTo(function() 
        love.graphics.clear(UI_LOGGING_BACKGROUND)
        love.graphics.setColor(1, 1, 1, 1)
        
        -- render logs
        for i = 1, #self.logs do
            local txt = self.logs[i].message
            local h = UI_LOGGING_FONT:getHeight(txt)
            local x, y = 0, (i - 1) * h

            -- render alternating background
            if (i % 2 == 0) then 
                love.graphics.setColor(1, 1, 1, 0.2)
                love.graphics.rectangle("fill", x, y, self.logBox:getWidth(), h)
            end

            -- set message type colors
            if self.logs[i].type == "error" then
                love.graphics.setColor(1, 0, 0, 1)
            elseif self.logs[i].type == "message" then
                love.graphics.setColor(1, 1, 1, 1)
            elseif self.logs[i].type == "notification" then
                love.graphics.setColor(1, 1, 0, 1)
            elseif type(self.logs[i].type) == "table" then
                love.graphics.setColor(self.logs[i].type)
            end

            love.graphics.print(txt, 0, y)

            love.graphics.setColor(1, 1, 1, 1)
        end
    end)

    -- draw log box
    love.graphics.setColor(1, 1, 1, (1 - logDisableTimer) / (logTimerMax))
    love.graphics.draw(self.logBox, 0, love.graphics.getHeight() - self.logBox:getHeight())
    love.graphics.setColor(1, 1, 1, 1)
end
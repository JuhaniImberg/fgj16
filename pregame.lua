Gamestate = require "hump.gamestate"

game = require "game"

pregame = {}

function pregame:init()
    self.font_size = 18
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 48),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function pregame:draw()
    local width, height = love.graphics.getDimensions()
    
    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Press any key when both players are ready.", 0, height*0.45, width, "center")

    love.graphics.setFont(self.fonts[2])
end

function pregame:next()
    love.audio.stop()
    Gamestate.switch(game)
end

function pregame:keyreleased(key)
    self:next()
end

function pregame:gamepadpressed(joystick, button)
    self:next()
end

return pregame

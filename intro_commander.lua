Gamestate = require "hump.gamestate"

story_commander = require "story_commander"

intro_commander = {}

function intro_commander:init()
    self.font_size = 18
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 48),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function intro_commander:draw()
    local width, height = love.graphics.getDimensions()
    
    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("The following is the background story for the honored Commander. \nThe Hero should look away. \nPress any key to continue.", 0, height*0.35, width, "center")

    love.graphics.setFont(self.fonts[2])
end

function intro_commander:next()
    Gamestate.switch(story_commander)
end

function intro_commander:keyreleased(key)
    self:next()
end

function intro_commander:gamepadpressed(joystick, button)
    self:next()
end

return intro_commander

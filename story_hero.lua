Gamestate = require "hump.gamestate"

intro_commander = require "intro_commander"

story_hero = {}

function story_hero:init()
    self.font_size = 28
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 48),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function story_hero:draw()
    local width, height = love.graphics.getDimensions()

    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Greetings, our mighty Hero!", 0, 0, width, "center")
    love.graphics.setFont(self.fonts[2])
    love.graphics.printf("The corrupt aristocracy of this state has decided to perform a forbidden ritual to gather more riches from this already dying world. You must stop them by any means: destroy the artefacts needed to perform the ritual by tossing them to the toxic flames of Mount Doom, and slaughter those who serve the greedy Commander. The ritual must be performed when the stars are in alignment, so delaying the ritual will also do. \n\n Move with the left stick, attack with the right stick, drop items with A. \n\nPress any key to continue.", 0, 120, width, "center")

end

function story_hero:next()
    Gamestate.switch(intro_commander)
end

function story_hero:keyreleased(key)
    self:next()
end

function story_hero:gamepadpressed(joystick, button)
    self:next()
end

return story_hero

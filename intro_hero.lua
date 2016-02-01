Gamestate = require "hump.gamestate"

story_hero = require "story_hero"

intro_hero = {}

function intro_hero:init()
    self.music = love.audio.newSource( "sound/ending.ogg" )
    love.audio.play(self.music)
    self.font_size = 18
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 48),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function intro_hero:draw()
    local width, height = love.graphics.getDimensions()
    
    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("The following is the background story for the mighty Hero of this world. \nThe Commander should look away. \n\nPress any key to continue.", 0, height*0.35, width, "center")

    love.graphics.setFont(self.fonts[2])
end

function intro_hero:next()
    Gamestate.switch(story_hero)
end

function intro_hero:keyreleased(key)
    self:next()
end

function intro_hero:gamepadpressed(joystick, button)
    self:next()
end

return intro_hero

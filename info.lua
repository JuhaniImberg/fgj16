Gamestate = require "hump.gamestate"

game = require "game"

info = {}

function info:init()
    self.music = love.audio.newSource( "sound/ending.ogg" )
    love.audio.play(self.music)
    self.font_size = 24
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 72),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function info:draw()
    local width, height = love.graphics.getDimensions()
    local offset = 200
    width = width / 2

    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Greetings, our mighty Hero!", 0, 0, width, "center")
        love.graphics.setFont(self.fonts[2])
        love.graphics.printf("The corrupt aristocracy of this state has decided to perform a forbidden ritual to gather more riches from this already dying world. You must stop them by any means: destroy the artefacts needed to perform the ritual by tossing them to the toxic flames of Mount Doom, and slaughter those who serve the greedy Commander. The ritual must be performed when the stars are in alignment, so delaying the ritual will also do. Press any key to continue.", 10, 300, 53*24/2, "center")

            love.graphics.setFont(self.fonts[1])
            love.graphics.setColor(255, 255, 255)
            love.graphics.printf("Greetings, our honored Commander!", 53*24/2, 0, width, "center")
                love.graphics.setFont(self.fonts[2])
                love.graphics.printf("The Elders have decided to finally migrate our people from this dying world. To accomplish this, a sacred teleportation ritual has to be performed. It's ingredients are scattered over the remains of this world and need to be gathered to the ritual site in time. You, the leader of a mighty army, were chosen to do this. But watch out for the \"Hero\". This arrogant youth is so attached to his own delusions that he might unknowingly doom us all by destroying the artefacts and slaughtering his own people sent to gather them.", 53*24/2, 300, 53*24/2, "center")

end

function info:next()
    love.audio.stop(self.music)
    Gamestate.switch(game)
end

function info:keyreleased(key)
    self:next()
end

function info:gamepadpressed(joystick, button)
    self:next()
end

return info

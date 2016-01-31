Gamestate = require "hump.gamestate"

endstate = {}

function endstate:init()
    self.music = love.audio.newSource( "sound/ending.ogg" )
    love.audio.play(self.music)
    self.font_size = 24
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 72),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function endstate:draw()
    local width, height = love.graphics.getDimensions()
    local offset = 200
    width = width / 2

    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(self.title, 0, 30, width, "center")
    love.graphics.draw(self.image, 100, 300, 0, 2)
    self.image:setFilter("nearest", "nearest")
    love.graphics.setFont(self.fonts[2])
    love.graphics.printf(self.message, 600, 400, width, "center")
end

function endstate:menu()
    love.audio.stop(self.music)
    Gamestate.switch(menu)
end

function endstate:keyreleased(key)
    self:menu()
end

function endstate:gamepadpressed(joystick, button)
    self:menu()
end

return endstate

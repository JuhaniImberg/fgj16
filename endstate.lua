Gamestate = require "hump.gamestate"

menu = {}

function menu:init()
    self.music = love.audio.newSource( "sound/menu.ogg" )
    self.music:setLooping(true)
    love.audio.play(self.music)
    self.font_size = 24
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 72),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function menu:draw()
    local width, height = love.graphics.getDimensions()
    local offset = 200
    width = width / 2

    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf(self.title, 0, 30, width, "center")
        love.graphics.setFont(self.fonts[2])
    love.graphics.printf(self.message, 600, 400, width, "center")
end

function menu:keyreleased(key)
end

function menu:gamepadpressed(joystick, button)
end

return menu

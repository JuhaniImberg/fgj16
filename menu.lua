Gamestate = require "hump.gamestate"

game = require "game"
editor = require "editor"

menu = {}

function menu:init()
    self.joysticks = {}
    self.music = love.audio.newSource( "sound/menu.ogg" )
    self.music:setLooping(true)
    love.audio.play(self.music)
end

function menu:draw()
    love.graphics.setColor(255, 255, 255)
    love.graphics.print("press 1 to game 2 to editor", 0, 0)
end

function menu:keyreleased(key)
    if key == "1" then
        Gamestate.switch(game)
        love.audio.stop(self.music)
    end
    if key == "2" then
        Gamestate.switch(editor)
        love.audio.stop(self.music)
    end
    Gamestate.current():joystickadded(joystick)
end

function menu:joystickadded(joystick)
    table.insert(self.joysticks, joystick)
end

return menu

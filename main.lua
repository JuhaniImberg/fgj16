Gamestate = require "hump.gamestate"

game = require "game"

function love.load()
    Gamestate.registerEvents()
    Gamestate.switch(game)
end

function love.joystickadded(joystick)
    Gamestate.current():joystickadded(joystick)
end

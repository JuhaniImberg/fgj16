Gamestate = require "hump.gamestate"

game = require "game"

function love.load()
    math.randomseed( os.time() )

    Gamestate.registerEvents()
    Gamestate.switch(game)
end

function love.joystickadded(joystick)
    Gamestate.current():joystickadded(joystick)
end

Gamestate = require "hump.gamestate"

game = require "game"
editor = require "editor"

function love.load()
    math.randomseed( os.time() )

    Gamestate.registerEvents()
    Gamestate.switch(editor)
end

function love.joystickadded(joystick)
    Gamestate.current():joystickadded(joystick)
end

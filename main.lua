Gamestate = require "hump.gamestate"

menu = require "menu"

function love.load()
    math.randomseed( os.time() )

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end

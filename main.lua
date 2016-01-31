Gamestate = require "hump.gamestate"

menu = require "menu"

function love.load()
    math.randomseed( os.time() )

    Gamestate.registerEvents()
    Gamestate.switch(menu)
end


function love.keyreleased(key)
    if key == "f11" then
        love.window.setFullscreen(not love.window.getFullscreen())
    end
end

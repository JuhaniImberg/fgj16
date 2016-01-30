function love.load()
    tileset = require "defaulttileset"

    map = { "...#....#...",
            "...#....#...",
            "............",
            ".##########.",
            "..#......#..",
            "...######...",
            "%..........?",
            }

    TM = require "tilemap"
    tm = TM(tileset, map)
end

function love.draw()
    tm:draw()
end

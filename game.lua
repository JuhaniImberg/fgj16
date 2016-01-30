tileset = require "defaulttileset"
TM = require "tilemap"


local game = {
    tm = nil
}

function game:init()
    map = { "...#....#...",
            "...#....#...",
            "............",
            ".##########.",
            "..#......#..",
            "...######...",
            "%..........?",
            }

    self.tm = TM(tileset, map)
end

function game:draw()
    self.tm:draw()
end

return game

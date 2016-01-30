vector = require "hump.vector"

tileset = require "defaulttileset"
TM = require "tilemap"
Hero = require "hero"


local game = {}

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
    self.entities = {}

    self.hero = Hero(vector(0, 0))
    table.insert(self.entities, self.hero)
end

function game:update(dt)
    for i, entity in ipairs(self.entities) do
        entity:update(dt)
    end
end

function game:draw()
    self.tm:draw()
    for i, entity in ipairs(self.entities) do
        entity:draw()
    end
end

function game:joystickadded(joystick)
    self.hero:setJoystick(joystick)
end

return game

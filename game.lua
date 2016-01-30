vector = require "hump.vector"

helpers = require "helpers"
tileset = require "defaulttileset"
TM = require "tilemap"
Hero = require "hero"
item = require "item"
Unit = require "unit"
MtDoom = require "mtdoom"
HQ = require "hq"
Commander = require "commander"


local game = {}

function game:init()
    map = { "#####################################################",
            "#................................................www#",
            "#................................................www#",
            "#................................................www#",
            "#...................................................#",
            "#...................................................#",
            "#.....########################################......#",
            "#...................................................#",
            "#...................................................#",
            "#...................................................#",
            "#....................................###########....#",
            "#..###################..............................#",
            "#...................................................#",
            "#...................................................#",
            "#................##############.....................#",
            "#.............................############..........#",
            "#...................................................#",
            "#...................................................#",
            "#...................................................#",
            "#...................................................#",
            "#...................................................#",
            "#...................................................#",
            "#...................................................#",
            "#................................................www#",
            "#................................................www#",
            "#................................................www#",
            "#................................................www#",
            "#................................................www#",
            "#................................................www#",
            "#####################################################",
            }

    self.tm = TM(tileset, map, 3)
    self.entities = {}
    self.items = {}

    for i=1, 4 do
        self:addRandomUnit()
        self:addRandomItem()
    end

    table.insert(self.entities, MtDoom(vector(24, 24)))
    table.insert(self.entities, HQ(vector(24, 28 * 24)))

    self.hero = Hero(vector(48, 48))
    self.commander = Commander(vector(48, 27 * 24))
    table.insert(self.entities, self.hero)
end

function game.addRandomUnit(self)
    table.insert(self.entities, Unit(vector(math.random(0, 53) * 24,
                                            math.random(0, 30) * 24)))
end

function game.addRandomItem(self)
    local ntype = item.itemtypes[math.random(#item.itemtypes)]
    local nitem = item.Item(vector(math.random(1, 51) * 24,
                                   math.random(1, 29) * 24),
                            ntype)
    table.insert(self.items, nitem)
end

function game:update(dt)
    self.tm:update(dt)
    for i, item in ipairs(self.items) do
        item:update(dt, self.entities)
    end
    self.commander:update(dt, self)
    for i, entity in ipairs(self.entities) do
        entity:update(dt, helpers.bind(self.tm, 'collides'), self, helpers.bind(self.tm, 'findPath'))
    end
end

function game:draw()
    self.tm:draw()
    for i, nitem in ipairs(self.items) do
        nitem:draw()
    end
    self.commander:draw()
    for i, entity in ipairs(self.entities) do
        entity:draw()
    end
end

function game:joystickadded(joystick)
    self.hero:setJoystick(joystick)
    -- self.commander:setJoystick(joystick)
end

return game

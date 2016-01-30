vector = require "hump.vector"

helpers = require "helpers"
tileset = require "defaulttileset"
TM = require "tilemap"
Hero = require "hero"
item = require "item"


local game = {}

function game:init()
    map = { "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#....................................................",
            "#...................................................w",
            "#...................................................w",
            "#...................................................w",
            "#....................................................",
            "#....................................................",
            "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            "#................................................wwww",
            }

    self.tm = TM(tileset, map, 3)
    self.entities = {}
    self.items = {}

    for i=1, 4 do
        self:addRandomItem()
    end

    self.hero = Hero(vector(48, 48))
    table.insert(self.entities, self.hero)
end

function game.addRandomItem(self)
    local ntype = item.itemtypes[math.random(#item.itemtypes)]
    local nitem = item.Item(vector(math.random(0, 53) * 24,
                                   math.random(0, 30) * 24),
                            ntype)
    table.insert(self.items, nitem)
end

function game:update(dt)
    self.tm:update(dt)
    for i, item in ipairs(self.items) do
        item:update(dt, self.entities)
    end
    for i, entity in ipairs(self.entities) do
        entity:update(dt, helpers.bind(self.tm, 'collides'))
    end
end

function game:draw()
    self.tm:draw()
    for i, nitem in ipairs(self.items) do
        nitem:draw()
    end
    for i, entity in ipairs(self.entities) do
        entity:draw()
    end
end

function game:joystickadded(joystick)
    self.hero:setJoystick(joystick)
end

return game

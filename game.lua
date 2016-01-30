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
    map0 = {}
    for line in io.lines("map-layer-0.data") do
        table.insert(map0, line)
    end
    map1 = {}
    for line in io.lines("map-layer-1.data") do
        table.insert(map1, line)
    end

    self.tm0 = TM(tileset, map0, 3)
    self.tm1 = TM(tileset, map1, 3)
    self.entities = {}
    self.items = {}

    self:genRandomItemList(8, 5)

    self.mtdoom =  MtDoom(vector(24, 24))
    self.hq = HQ(vector(24, 28 * 24))
    table.insert(self.entities, self.mtdoom)
    table.insert(self.entities, self.hq)

    self.hero = Hero(vector(48, 48))
    self.commander = Commander(vector(48, 27 * 24))
    table.insert(self.entities, self.hero)

    self.music = love.audio.newSource( "sound/game.ogg" )
    love.audio.play(self.music)
end

function game:addRandomUnit()
    table.insert(self.entities, Unit(vector(math.random(1, 52) * 24,
                                            math.random(1, 31) * 24)))
end

function game:spawnUnit(target)
    table.insert(self.entities, Unit(self.hq.pos:clone(),
                                     target:clone()))
end

function game:addItem(item_type, ritual)
    local nitem = item.Item(item_type, ritual)
    table.insert(self.items, nitem)
end

function game:rekt(entity)
    for i=#self.entities, 1, -1 do
        if self.entities[i] == entity then
            table.remove(self.entities, i)
        end
    end
end

function game:setUnitTarget(target)
    for i=#self.entities, 1, -1 do
        if self.entities[i].unit then
            self.entities[i].target = target:clone()
        end
    end
end

function game:addRandomItem()
    local ntype = item.itemtypes[math.random(#item.itemtypes)]
    local nitem = item.Item(vector(math.random(1, 51) * 24,
                                   math.random(1, 29) * 24),
                            ntype)
    table.insert(self.items, nitem)
end

function game:genRandomItemList(count, ritual_count)
    local all = {}
    local items = {}
    for i=1, #item.itemtypes do
        table.insert(all, item.itemtypes[i])
    end
    for i=1, count do
        local index = math.random(1, #all)
        self:addItem(all[index], i<=ritual_count)
        table.remove(all, index)
    end

    return items
end

function game:update(dt)
    self.tm0:update(dt)
    self.tm1:update(dt)
    for i, item in ipairs(self.items) do
        item:update(dt, self.entities)
    end
    self.commander:update(dt, self)
    for i, entity in ipairs(self.entities) do
        entity:update(dt, helpers.bind(self.tm1, 'collides'), self, helpers.bind(self.tm1, 'findPath'))
    end
end

function game:draw()
    self.tm0:draw()
    self.tm1:draw()
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

function game:gamepadpressed(js, button)
    print(button)
end

function game:mousemoved(x, y)
    self.commander.pos.x = x - 12
    self.commander.pos.y = y - 12
end

function game:mousepressed(x, y, button)
    self.commander.pos.x = x - 12
    self.commander.pos.y = y - 12
    if button == 1 then
        self:spawnUnit(self.commander.pos)
    end
    if button == 2 then
        self:setUnitTarget(self.commander.pos)
    end
end

return game

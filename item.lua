Class = require "hump.class"

Item = Class{
    init = function(self, itype, ritual)
        self.pos = itype.pos
        self.itype = itype
        self.width = width or 24
        self.height = height or 24
        self.being_carried = false
        self.destroyed = false
        self.captured = false
        self.ritual_item = ritual
    end,
    middlepoint = function(self)
        return self.pos + vector(self.width / 2, self.height / 2)
    end,
    update = function(self, dt, entities)
        if self.being_carried then
            return
        end
        for i, entity in ipairs(entities) do
            local dist = self:middlepoint():dist(entity:middlepoint())
            if dist < entity.radius and entity:pickItem(self) then
                self.being_carried = true
                return
            end
        end
    end,
    dropped = function(self)
        self.being_carried = false
    end,
    draw = function(self)
        if not self.being_carried then
            self.itype:draw(self.pos, self.width, self.height)
        end
    end
}

ItemType = Class{
    init = function(self, name, image, pos)
        self.name = name
        self.image = image
        self.pos = pos
    end,
    draw = function(self, pos, width, height)
        love.graphics.draw(self.image, pos.x, pos.y)
    end
}

itemtypes = {
    ItemType("Beehive", love.graphics.newImage("graphics/beehive.png"), vector(1,1)),
    ItemType("Bucket", love.graphics.newImage("graphics/bucket.png"), vector(1,1)),
    ItemType("Coin", love.graphics.newImage("graphics/coin.png"), vector(1,1)),
    ItemType("Crown", love.graphics.newImage("graphics/crown.png"), vector(1,1)),
    ItemType("Deadfish", love.graphics.newImage("graphics/deadfish.png"), vector(1,1)),
    ItemType("Excalibur", love.graphics.newImage("graphics/enchantedsword.png"), vector(1,1)),
    ItemType("Fang", love.graphics.newImage("graphics/fang.png"), vector(1,1)),
    ItemType("Goat", love.graphics.newImage("graphics/goat.png"), vector(1,1)),
    ItemType("Goblet", love.graphics.newImage("graphics/goblet.png"), vector(1,1)),
    ItemType("Pearl", love.graphics.newImage("graphics/pearl.png"), vector(1,1)),
    ItemType("PinkOrb", love.graphics.newImage("graphics/pinkorb.png"), vector(1,1)),
    ItemType("Ruby", love.graphics.newImage("graphics/ruby.png"), vector(1,1)),
    ItemType("Fiddle", love.graphics.newImage("graphics/scarecrow.png"), vector(1,1)),
    ItemType("Shovel", love.graphics.newImage("graphics/shovel.png"), vector(1,1)),
    ItemType("Tiara", love.graphics.newImage("graphics/tiara.png"), vector(1,1)),
}

return {
    itemtypes=itemtypes,
    ItemType=ItemType,
    Item=Item
}

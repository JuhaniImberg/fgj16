Class = require "hump.class"

Item = Class{
    init = function(self, pos, itype)
        self.pos = pos
        self.itype = itype
        self.width = width or 24
        self.height = height or 24
        self.being_carried = false
        self.destroyed = false
        self.captured = false
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
    init = function(self, name, image)
        self.name = name
        self.image = image
    end,
    draw = function(self, pos, width, height)
        love.graphics.draw(self.image, pos.x, pos.y)
    end
}

itemtypes = {
    ItemType("Beehive", love.graphics.newImage("graphics/beehive.png")),
    ItemType("Bucket", love.graphics.newImage("graphics/bucket.png")),
    ItemType("Coin", love.graphics.newImage("graphics/coin.png")),
    ItemType("Crown", love.graphics.newImage("graphics/crown.png")),
    ItemType("Deadfish", love.graphics.newImage("graphics/deadfish.png")),
    ItemType("Excalibur", love.graphics.newImage("graphics/enchantedsword.png")),
    ItemType("Fang", love.graphics.newImage("graphics/fang.png")),
    ItemType("Goat", love.graphics.newImage("graphics/goat.png")),
    ItemType("Goblet", love.graphics.newImage("graphics/goblet.png")),
    ItemType("Pearl", love.graphics.newImage("graphics/pearl.png")),
    ItemType("PinkOrb", love.graphics.newImage("graphics/pinkorb.png")),
    ItemType("Ruby", love.graphics.newImage("graphics/ruby.png")),
    ItemType("Fiddle", love.graphics.newImage("graphics/scarecrow.png")),
    ItemType("Shovel", love.graphics.newImage("graphics/shovel.png")),
    ItemType("Tiara", love.graphics.newImage("graphics/tiara.png")),
}

return {
    itemtypes=itemtypes,
    ItemType=ItemType,
    Item=Item
}

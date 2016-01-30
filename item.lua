Class = require "hump.class"

Item = Class{
    init = function(self, pos, itype)
        self.pos = pos
        self.itype = itype
        self.width = width or 24
        self.height = height or 24
        self.being_carried = false
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
            if dist < 8 and entity:pickItem(self) then
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
    init = function(self, name, r, g, b)
        self.name = name
        self.r = r
        self.g = g
        self.b = b
    end,
    draw = function(self, pos, width, height)
        love.graphics.setColor(self.r, self.g, self.b)
        love.graphics.rectangle("fill", pos.x, pos.y, width, height)
    end
}

itemtypes = {
    ItemType("testitem-01", 125, 125, 255),
    ItemType("testitem-02", 255, 125, 125)
}

return {
    itemtypes=itemtypes,
    ItemType=ItemType,
    Item=Item
}

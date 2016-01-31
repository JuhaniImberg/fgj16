Entity = require "entity"

GatherPoint = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos)
        self.destroy = false
        self.capture = false
        self.count = 0
        self.radius = 48
        self.items = {}
        self.ritual_items = 0
    end,
    update = function(self, dt)
        if self.carrying then
            if self.destroy then
                self.carrying.destroyed = true
            end
            if self.capture then
                self.carrying.captured = true
            end
            table.insert(self.items, self.carrying)
            if self.carrying.ritual_item then
                self.ritual_items = self.ritual_items + 1
            end
            self.carrying = nil
            self.count = self.count + 1
        end
    end,
    draw = function(self)
        love.graphics.setColor(255, 255, 255)
        love.graphics.printf(self.count, self.pos.x, self.pos.y - 10, self.width, "center")
    end
}

return GatherPoint

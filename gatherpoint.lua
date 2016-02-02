Entity = require "entity"

GatherPoint = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos)
        self.destroys = false
        self.captures = false
        self.count = 0
        self.radius = 48
        self.items = {}
        self.ritual_items = 0
        self.textcolor = {255,255,255}
    end,
    update = function(self, dt)
        if self.carrying then
            if self.destroys then
                self.carrying.destroyed = true
            end
            table.insert(self.items, self.carrying)
            if self.captures then
                self.carrying.captured = true
            end
            if self.carrying.ritual_item then
                self.ritual_items = self.ritual_items + 1
            end
            self.carrying = nil
            self.count = self.count + 1
        end
        if self.captures then
            for i, item in ipairs(self.items) do
                item.pos = item.pos + (-item.pos + self.pos + vector(math.cos(2*math.pi*(i/#self.items)+love.timer.getTime()*2)*48, math.cos(i*2+2*math.pi*love.timer.getTime()*0.7)*8 + math.sin(2*math.pi*(i/#self.items)+love.timer.getTime()*2)*48))*0.01
            end
        end
    end,
    draw = function(self)
        love.graphics.setColor(0, 0, 0, 180)
        love.graphics.printf(self.count, self.pos.x+2, self.pos.y - 12, self.width, "center")
        love.graphics.setColor(self.textcolor[1], self.textcolor[2], self.textcolor[3])
        love.graphics.printf(self.count, self.pos.x, self.pos.y - 10, self.width, "center")
    end
}

return GatherPoint

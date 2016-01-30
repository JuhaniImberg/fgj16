vector = require "hump.vector"

Entity = require "entity"

CollidingEntity = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos, 16, 16)
    end,
    move = function(self, dir, dt, collfn)
        local steps = math.floor(self.speed*dt + 1)
        local step = (self.speed*dt)/steps
        for i=1, steps do
            self.pos.y = self.pos.y + (dir * step).y
            local xcol, ycol = collfn(self)

            if ycol then
                self.pos.y = math.floor(self.pos.y/24)*24
                if dir.y < 0 then
                    self.pos.y = self.pos.y + 24
                else
                    self.pos.y = self.pos.y + 7
                end
            end
            self.pos.x = self.pos.x + (dir * step).x
            local xcol, ycol = collfn(self)
            if xcol then
                self.pos.x = math.floor(self.pos.x/24)*24
                if dir.x < 0 then
                    self.pos.x = self.pos.x + 24
                else
                    self.pos.x = self.pos.x + 7
                end
            end
        end
    end
}

return CollidingEntity

vector = require "hump.vector"

Entity = require "entity"

Unit = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos, 16, 16)
        self.speed = 75
    end,
    update = function(self, dt, collfn, game, pathfn)
        local trg = self:getPath(dt, game, pathfn)
        if trg ~= nil then
            self.dir =  trg*24 + vector(6, 0) - self.pos + vector(8,8)
            self.pos = self.pos + self.dir:normalized() * dt * self.speed
        end
    end,
    draw = function(self)
        if self.carrying then
            love.graphics.setColor(0, 0, 200)
        else
            love.graphics.setColor(0, 0, 255)
        end
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
    end,
    getPath = function(self, dt, game, pathfn)
        if self.trg ~= nil then
            if (self.trg*24-self.pos + vector(8,8)):len() > 8 then
                return self.trg
            end
        end
        local mid = game.hero:middlepoint():clone()
        local pos = self.pos:clone() + vector(8,8)
        mid.x = math.floor(mid.x/24)
        mid.y = math.floor(mid.y/24)
        pos.x = math.floor(pos.x/24)
        pos.y = math.floor(pos.y/24)
        self.trg = (pathfn(pos,mid) or {nil})[1]
        return self.trg
    end
}

return Unit

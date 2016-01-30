vector = require "hump.vector"

Entity = require "entity"

Unit = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos, 16, 16)
        self.speed = 75
    end,
    update = function(self, dt, collfn, game)
        self.pos = self.pos + ((game.hero:middlepoint() - self.pos):normalized() * self.speed * dt)
    end,
    draw = function(self)
        if self.carrying then
            love.graphics.setColor(0, 0, 200)
        else
            love.graphics.setColor(0, 0, 255)
        end
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
    end
}

return Unit

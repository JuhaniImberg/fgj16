Class = require "hump.class"


Projectile = Class{
    init = function(self, pos, dir, target)
        self.pos = pos
        self.dir = dir
        self.target = target
        self.speed = 200
        self.lifetime = 0.2
    end,
    update = function(self, dt, entities, game)
        self.pos = self.pos + (dt * self.speed * self.dir)
        self.lifetime = self.lifetime - dt
        if self.lifetime <= 0 then
            game:projectileRekt(self)
            return
        end
        for i, entity in ipairs(entities) do
            if entity:middlepoint():dist(self.pos) < 8 and entity[self.target] ~= nil then
                entity:takeDamage()
                game:projectileRekt(self)
                return
            end
        end
    end,
    draw = function(self)
        love.graphics.setColor(255, 255, 255)
        love.graphics.circle("fill", self.pos.x, self.pos.y, 4, 8)
    end
}

return Projectile

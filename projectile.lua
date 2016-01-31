Class = require "hump.class"


local proj_img = love.graphics.newImage("graphics/puncheffect.png")
local proj_sounds = {
    love.audio.newSource("sound/sword1.ogg"),
    love.audio.newSource("sound/sword2.ogg"),
    love.audio.newSource("sound/sword3.ogg")
}

Projectile = Class{
    init = function(self, pos, dir, target, lifetime)
        self.pos = pos
        self.dir = dir
        self.target = target
        self.speed = 200
        self.lifetime = lifetime or 0.3
        self.quad = love.graphics.newQuad(0, 0, 24, 24, 96, 24)
        local sound = proj_sounds[math.random(1, #proj_sounds)]
        love.audio.play(sound)
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
        local pos = self.pos:clone() + vector(-12, -12):rotated(self.dir:angleTo())
        love.graphics.draw(proj_img, self.quad, pos.x, pos.y, self.dir:angleTo())
    end
}

return Projectile

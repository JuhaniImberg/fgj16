vector = require "hump.vector"

Entity = require "entity"

Unit = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos, 16, 16)
        self.image = love.graphics.newImage("graphics/elf.png")
        self.quad = love.graphics.newQuad(0, 0, 18, 18, self.image:getWidth(), self.image:getHeight())
        self.speed = 75
        self.flipper = false
    end,
    update = function(self, dt, collfn, game, pathfn)
        local time = love.timer.getTime()
        local image_ind = (math.floor(3*time))%4
        if image_ind == 3 then
            image_ind = 1
        end

        self.quad:setViewport(image_ind * 18, 0, 18, 18)
        local trg = self:getPath(dt, game, pathfn)
        if trg ~= nil then
            self.dir =  trg*24 + vector(6, 0) - self.pos + vector(8,8)
            self.pos = self.pos + self.dir:normalized() * dt * self.speed
            if self.dir.x > 0 then
                self.flipped = true
            else
                self.flipped = false
            end
        end

        if self.carrying and self:middlepoint():dist(game.hq:middlepoint()) < 16 then
            self:dropItem()
        end
    end,
    draw = function(self)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.image,
                           self.quad,
                           math.floor(self.pos.x + 0.5 - (self.flipped and -18 or 0)),
                           math.floor(self.pos.y + 0.5),
                           0,
                           (self.flipped and -1 or 1),
                           1)
    end,
    getPath = function(self, dt, game, pathfn)
        if self.trg ~= nil then
            if (self.trg*24-self.pos + vector(8,8)):len() > 8 then
                return self.trg
            end
        end
        local mid = self.carrying and game.hq:middlepoint():clone() or game.hero:middlepoint():clone()
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

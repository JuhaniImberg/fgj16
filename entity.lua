Class = require "hump/class"

Entity = Class{
    init = function(self, pos, width, height)
        self.pos = pos
        self.width = width or 24
        self.height = height or 24
        self.speed = speed or 100
        self.carrying = nil
        self.radius = 8
        self.slowspeed = 50
        self.highspeed = self.speed
        self.hp = 5
        self.last_hit = 0
        self.hurt_time = 0.25
        self.hurt_cd = 0.5
        self.fire_cd = 0.4
        self.last_fire = 0
        self.last_drop = 0
        self.pickup_cd = 0.25
    end,
    takeDamage = function(self)
        if self.hp <= 0 then
            return
        end
        if self.last_hit + self.hurt_time + self.hurt_cd > love.timer.getTime() then
            return
        end
        self.hp = self.hp - 1
        self.last_hit = love.timer.getTime()
        if self.gettingRekt then
            self:gettingRekt()
        end
    end,
    getHP = function(self)
        return self.hp
    end,
    checkRekt = function(self, game)
        if self.hp <= 0 then
            self:dropItem()
            game:rekt(self)
            return true
        end
        return false
    end,
    middlepoint = function(self)
        return self.pos + vector(self.width / 2, self.height / 2)
    end,
    boundingBox = function(self)
        local bb = vector(self.width, self.height)
        return self.pos, self.pos + bb
    end,
    draw = function(self)

    end,
    pickItem = function(self, item)
        if self.carrying or self.last_drop + self.pickup_cd > love.timer.getTime() then
            return false
        end
        self.carrying = item
        self.speed = self.slowspeed
        item:pickup(self)
        return true
    end,
    dropItem = function(self)
        if not self.carrying then
            return false
        end
        local mid = self:middlepoint()
        self.carrying.pos = vector(math.floor(mid.x / 24) * 24,
                                   math.floor(mid.y / 24) * 24)
        self.carrying:dropped()
        self.carrying = nil
        self.speed = self.highspeed
        self.last_drop = love.timer.getTime()
    end,
    drawColor = function(self)
        if self.last_hit + self.hurt_time > love.timer.getTime() and math.floor(love.timer.getTime()*100)%2 == 0 then
            love.graphics.setColor(255, 0, 0)
        elseif self.carrying and love.timer.getTime() % 1 < 0.5 then
            love.graphics.setColor(255, 255, 0)
        else
            love.graphics.setColor(255, 255, 255)
        end
    end
}

return Entity

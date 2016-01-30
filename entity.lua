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
        if self.carrying then
            return false
        end
        self.carrying = item
        self.speed = self.slowspeed
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
    end
}

return Entity

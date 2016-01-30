Class = require "hump/class"

Entity = Class{
    init = function(self, pos, width, height)
        self.pos = pos
        self.width = width or 24
        self.height = height or 24
        self.speed = speed or 100
    end,
    draw = function(self)

    end
}

return Entity

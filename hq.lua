GatherPoint = require "gatherpoint"


HQ = Class{
    __includes = GatherPoint,
    init = function(self, pos)
        GatherPoint.init(self, pos)
        self.captures = true
    end,
    draw = function(self)
        love.graphics.setColor(0, 0, 255)
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
        GatherPoint.draw(self)
    end
}

return HQ

GatherPoint = require "gatherpoint"


MtDoom = Class{
    __includes = GatherPoint,
    init = function(self, pos)
        GatherPoint.init(self, pos)
        self.destroys = true
    end,
    draw = function(self)
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
        GatherPoint.draw(self)
    end
}

return MtDoom

GatherPoint = require "gatherpoint"


MtDoom = Class{
    __includes = GatherPoint,
    init = function(self, pos)
        GatherPoint.init(self, pos)
        self.destroys = true
        self.textcolor = {255,0,0}
    end,
}

return MtDoom

GatherPoint = require "gatherpoint"


MtDoom = Class{
    __includes = GatherPoint,
    init = function(self, pos)
        GatherPoint.init(self, pos)
        self.destroys = true
    end,
}

return MtDoom

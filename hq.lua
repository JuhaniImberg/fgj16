GatherPoint = require "gatherpoint"


HQ = Class{
    __includes = GatherPoint,
    init = function(self, pos)
        GatherPoint.init(self, pos)
        self.captures = true
    end,
}

return HQ

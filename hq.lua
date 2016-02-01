GatherPoint = require "gatherpoint"


HQ = Class{
    __includes = GatherPoint,
    init = function(self, pos)
        GatherPoint.init(self, pos)
        self.captures = true
        self.textcolor = {0,255,255}
    end,
}

return HQ

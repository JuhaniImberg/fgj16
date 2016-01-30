Class = require "hump/class"

ti = {}

ti.TileInfo = Class{
    init = function(self, char, x, y, solid)
        self.char = char
        self.x = x
        self.y = y
        self.animated = false
        self.solid = solid or false
    end
}

ti.AnimatedTileInfo = Class{
    __includes = TileInfo,
    init = function(self, char, positions)
        ti.TileInfo.init(self, char, positions[1].x, positions[1].y)
        self.positions = positions
        self.cur = 1
        self.animated = true
    end,
    next = function(self)
        if self.cur == #self.positions then
            self.cur = 1
        else
            self.cur = self.cur + 1
        end
        self.x = self.positions[self.cur].x
        self.y = self.positions[self.cur].y
    end
}

return ti;

Class = require "hump/class"

ti = {}

ti.TileInfo = Class{
    init = function(self, char, x, y, solid)
        self.char = char
        self.x = x
        self.y = y
        self.animated = false
        self.solid = solid or false
    end,
    setTileInfo = function(self, tw, th, iw, ih)
        self.w = tw
        self.h = th
        self.iw = iw
        self.ih = ih
    end,
    getQuad = function(self)
        return love.graphics.newQuad(self.x*self.w,self.y*self.h, self.w,
            self.h, self.iw, self.ih)
    end,
    isAnimated = function(self)
        return self.animated
    end
}

ti.AnimatedTileInfo = Class{
    __includes = ti.TileInfo,
    init = function(self, char, positions, solid)
        ti.TileInfo.init(self, char, positions[1].x, positions[1].y, solid or false)
        self.positions = positions
        self.animated = true
    end,
    getNextQuad = function(self, time)
        local cur = (time-1) % #self.positions + 1
        self.x = self.positions[cur].x
        self.y = self.positions[cur].y
        return ti.TileInfo.getQuad(self)
    end
}

return ti;

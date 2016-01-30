Class = require "hump/class"

TileInfo = Class{
    init = function(self, char, x, y)
        self.char = char
        self.x = x
        self.y = y
    end
}

return TileInfo;

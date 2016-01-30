Class = require "hump/class"


TileMap = Class{
    init = function(self, tileset, mapstr)
        self.tileset = tileset
        self.map = {}
        self.sb = love.graphics.newSpriteBatch(tileset.image)
        self.ids = {}
        self.animated = {}
        self.frame = 1
        for y = 1, #map do
            col = map[y];
            self.map[y] = {}
            self.ids[y] = {}
            for x=1, #col do
                local c = col:sub(x,x)
                self.map[y][x] = c
                local tile_info = self.tileset:getTileInfo(c)
                if tile_info:isAnimated() then
                    table.insert(self.animated, {x=x, y=y})
                end
                self.ids[y][x] = self.sb:add(tile_info:getQuad(),
                    (x-1)*self.tileset.tile_width,(y-1)*self.tileset.tile_height)
            end
        end
    end,
    draw = function(self)
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.sb)
    end,
    update = function(self)
        for i=1, #self.animated do
            self.frame = self.frame + 1
            local a = self.animated[i]
            local id = self.ids[a.y][a.x]
            local ti = self.tileset:getTileInfo(self.map[a.y][a.x])
            local quad = ti:getNextQuad(self.frame)
            self.sb:set(id, quad,
                (a.x-1)*self.tileset.tile_width,(a.y-1)*self.tileset.tile_height)
        end
    end
}

return TileMap;

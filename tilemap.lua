Class = require "class"

TileMap = Class{
    init = function(self, tileset, map)
        self.tileset = tileset
        self.tiles = map
        self.quads = {}
        for i=1, #tileset.tiles do
            self.quads[tileset.tiles[i].c] = love.graphics.newQuad(tileset.tiles[i].x*tileset.tile_size.w,
                tileset.tiles[i].y*tileset.tile_size.h, tileset.tile_size.w, tileset.tile_size.h,tileset.image:getWidth(), tileset.image:getHeight())
        end
        self.sb = love.graphics.newSpriteBatch(tileset.image)
        self.ids = {}
        for y = 1, #map do
            col = map[y];
            self.ids[y] = {}
            for x=1, #col do
                local c = col:sub(x,x)
                self.ids[y][x] = self.sb:add(self.quads[c], (x-1)*self.tileset.tile_size.w,(y-1)*self.tileset.tile_size.h)
            end
        end
    end,
    draw = function(self)
        love.graphics.draw(self.sb)
    end,
    setTile = function(self, x, y, c)
        self.ids[y][x] = self.sb:set(self.ids[y][x], self.quads[c], (x-1)*self.tileset.tile_size.w, (y-1)*self.tileset.tile_size.h);
    end
}

return TileMap;

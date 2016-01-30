Class = require "hump/class"

TileSet = Class{
    init = function(self, image_path, tile_width, tile_height, tile_infos)
        self.image =  love.graphics.newImage(image_path)
        self.tile_width = tile_width
        self.tile_height = tile_height
        self.tiles = tile_infos
        for i=1, #self.tiles do
            local tile = self.tiles[i]
            tile:setTileInfo(tile_width, tile_height, self.image:getWidth(), self.image:getHeight())
            self.tiles[tile.char] = tile
        end
    end,
    getTileInfo = function(self, char)
        return self.tiles[char]
    end
}

return TileSet;

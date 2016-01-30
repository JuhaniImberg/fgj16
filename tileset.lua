Class = require "hump/class"

TileSet = Class{
    init = function(self, image_path, tile_width, tile_height, tile_infos)
        self.image =  love.graphics.newImage(image_path)
        self.tile_width = tile_width
        self.tile_height = tile_height
        self.tiles = tile_infos
    end
}

return TileSet;

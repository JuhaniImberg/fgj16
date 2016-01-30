TileSet = require "tileset"
Tile = require "tileinfo"

return TileSet("tileset.png", 24, 24, {
    TileInfo(".", 0, 0),
    TileInfo("#", 1, 0),
    TileInfo("%", 0, 1),
    TileInfo("?", 1, 1)
})

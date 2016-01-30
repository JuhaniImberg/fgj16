TileSet = require "tileset"
ti = require "tileinfo"

return TileSet("graphics/tileset.png", 24, 24, {
    ti.TileInfo(".", 0, 0),
    ti.TileInfo("#", 8, 3, true),
    ti.AnimatedTileInfo("w", {{x=7,y=0}})
})

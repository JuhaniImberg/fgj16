TileSet = require "tileset"
ti = require "tileinfo"

return TileSet("graphics/tileset.png", 24, 24, {
    ti.TileInfo(".", 0, 0),
    ti.TileInfo("#", 0, 1, true),
    ti.AnimatedTileInfo("w", {{x=2,y=1}})
})

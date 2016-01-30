TileSet = require "tileset"
ti = require "tileinfo"

return TileSet("tileset.png", 24, 24, {
    ti.TileInfo(".", 0, 0),
    ti.TileInfo("#", 1, 0, true),
    ti.TileInfo("%", 0, 1),
    ti.TileInfo("?", 1, 1),
    ti.AnimatedTileInfo("w", {{x=0,y=2},{x=0,y=3},{x=0,y=4}})
})

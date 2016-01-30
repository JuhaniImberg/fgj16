TileSet = require "tileset"
ti = require "tileinfo"

return TileSet("tileset.png", 24, 24, {
    ti.TileInfo(".", 0, 0),
    ti.TileInfo("#", 1, 0),
    ti.TileInfo("%", 0, 1),
    ti.TileInfo("?", 1, 1),
    ti.AnimatedTileInfo("W", {{x=0,y=0},{x=1,y=0}})
})

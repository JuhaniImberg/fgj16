TileSet = require "tileset"
ti = require "tileinfo"

return TileSet("graphics/tileset.png", 24, 24, {
    ti.TileInfo(".", 0, 0),
    ti.TileInfo("#", 8, 3, true),
    ti.AnimatedTileInfo("w", {{x=7,y=0}, {x=3,y=4}, {x=4,y=4}, {x=5,y=4}})
})

local tileset = {}

tileset.tile_size = {w=24, h=24}
tileset.tiles = {
    {c=".", x=0, y=0},
    {c="#", x=1, y=0},
    {c="%", x=0, y=1},
    {c="?", x=1, y=1}
}
tileset.image = love.graphics.newImage("tileset.png")

return tileset

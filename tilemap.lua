Class = require "hump/class"
vector = require "hump/vector"


TileMap = Class{
    init = function(self, tileset, mapstr, animation_speed)
        self.tileset = tileset
        self.animation_speed = 1/animation_speed
        self.map = {}
        self.sb = love.graphics.newSpriteBatch(tileset.image, #mapstr * #mapstr[1])
        self.ids = {}
        self.animated = {}
        self.collisions = {}
        self.frame = 1
        for y = 1, #map do
            col = map[y];
            self.map[y] = {}
            self.ids[y] = {}
            self.collisions[y] = {}
            for x=1, #col do
                local c = col:sub(x,x)
                self.map[y][x] = c
                local tile_info = self.tileset:getTileInfo(c)
                if tile_info:isAnimated() then
                    table.insert(self.animated, {x=x, y=y})
                end
                self.collisions[y][x] = tile_info.solid
                self.ids[y][x] = self.sb:add(tile_info:getQuad(),
                    (x-1)*self.tileset.tile_width,(y-1)*self.tileset.tile_height)
            end
        end
    end,
    draw = function(self)
        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.sb)
    end,
    update = function(self, dt)
        self.frame = self.frame + dt
        for i=1, #self.animated do
            local a = self.animated[i]
            local id = self.ids[a.y][a.x]
            local ti = self.tileset:getTileInfo(self.map[a.y][a.x])
            local quad = ti:getNextQuad(math.floor(self.frame / self.animation_speed))
            self.sb:set(id, quad,
                (a.x-1)*self.tileset.tile_width,(a.y-1)*self.tileset.tile_height)
        end
    end,
    collides = function(self, entity)
        local epos, epos2 = entity:boundingBox()

        local ycol, xcol = false, false

        if math.floor(epos2.y / self.tileset.tile_height)-1 >= #self.collisions or epos.y / self.tileset.tile_height <= 0 then
            ycol = true
        else
            if self.collisions[math.floor(epos.y/self.tileset.tile_height)+1][math.floor((epos.x)/self.tileset.tile_width)+1]
                or self.collisions[math.floor(epos.y/self.tileset.tile_height)+1][math.floor((epos2.x)/self.tileset.tile_width)+1]
                or self.collisions[math.floor(epos2.y/self.tileset.tile_height)+1][math.floor((epos.x)/self.tileset.tile_width)+1]
                or self.collisions[math.floor(epos2.y/self.tileset.tile_height)+1][math.floor((epos2.x)/self.tileset.tile_width)+1] then
                ycol = true
            end
        end
        if math.floor(epos2.x / self.tileset.tile_width)-1 >= #self.collisions[1] or epos.x / self.tileset.tile_width <= 0 then
            xcol = true
        else
            if self.collisions[math.floor((epos.y)/self.tileset.tile_height)+1][math.floor((epos.x)/self.tileset.tile_width)+1]
                or self.collisions[math.floor((epos.y)/self.tileset.tile_height)+1][math.floor((epos2.x)/self.tileset.tile_width)+1]
                or self.collisions[math.floor((epos2.y)/self.tileset.tile_height)+1][math.floor((epos.x)/self.tileset.tile_width)+1]
                or self.collisions[math.floor((epos2.y)/self.tileset.tile_height)+1][math.floor((epos2.x)/self.tileset.tile_width)+1] then
                xcol = true
            end
        end
        return xcol, ycol
    end
}

return TileMap;

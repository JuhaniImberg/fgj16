Class = require "hump/class"


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
        local yrange = {math.max(1, math.floor(epos.y / self.tileset.tile_height) - 1),
                        math.min(#self.collisions, math.floor(epos2.y / self.tileset.tile_height) + 2)}
        for y=yrange[1], yrange[2] do
            local xrange = {math.max(1, math.floor(epos.x / self.tileset.tile_width) - 1),
                            math.min(#self.collisions[y], math.floor(epos2.x / self.tileset.tile_width) + 2)}
            for x=xrange[1], xrange[2] do
                local solid = self.collisions[y][x]
                if solid then
                    local pos = vector((x-1) * self.tileset.tile_width, (y-1) * self.tileset.tile_height)
                    local pos2 = pos + vector(self.tileset.tile_width, self.tileset.tile_height)
                    if epos.x < pos2.x and epos2.x > pos.x and epos.y < pos2.y and epos2.y > pos.y then
                        return true
                    end
                end
            end
        end
        return false
    end
}

return TileMap;

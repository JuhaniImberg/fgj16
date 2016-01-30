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
        self.visible = true
        for y = 1, #mapstr do
            col = mapstr[y];
            self.map[y] = {}
            self.ids[y] = {}
            self.collisions[y] = {}
            for x=1, #col do
                local c = col:sub(x,x)
                self:setTile(x, y, c)
            end
        end
    end,
    setTile = function(self, x, y, c)
        self.map[y][x] = c
        local tile_info = self.tileset:getTileInfo(c)
        if tile_info:isAnimated() then
            table.insert(self.animated, {x=x, y=y})
        end
        self.collisions[y][x] = tile_info.solid
        if self.ids[y][x] then
            self.sb:set(self.ids[y][x],
                        tile_info:getQuad(),
                        (x-1)*self.tileset.tile_width,
                        (y-1)*self.tileset.tile_height)
        else
            self.ids[y][x] = self.sb:add(tile_info:getQuad(),
                                         (x-1)*self.tileset.tile_width,
                                         (y-1)*self.tileset.tile_height)
        end
    end,
    getTileChar = function(self, x, y)
        return self.map[y][x]
    end,
    draw = function(self)
        if not self.visible then
            return
        end
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
    end,
    findPath = function(self, from, to)
        local queue = {from}
        local visited = {}
        for i=1, #self.collisions do
            visited[i] = {}
        end
        local i=0
        while i ~= #queue do
            i = i + 1
            local cur = queue[i]
            if (cur.x == to.x and cur.y == to.y) then
                local path = {}
                while cur.x ~= from.x or cur.y ~= from.y do
                    table.insert(path, vector(cur.x, cur.y))
                    cur = queue[cur.parent]
                end
                if #path == 0 then
                    table.insert(path, vector(cur.x, cur.y))
                end
                for i=1, math.floor(#path / 2) do
                    local tmp = path[i]
                    path[i] = path[#path - i + 1]
                    path[#path - i + 1] = tmp
                end
                return path
            end
            local neighbors = {}
            if cur.x ~= 1 and not visited[cur.y][cur.x-1] and not self.collisions[cur.y+1][cur.x-1+1] then
                table.insert(neighbors, {x=cur.x-1, y=cur.y, parent=i})
                visited[cur.y][cur.x-1] = true
            end
            if cur.x < #self.collisions[cur.y]  and not visited[cur.y][cur.x+1] and not self.collisions[cur.y+1][cur.x+1+1]  then
                table.insert(neighbors, {x=cur.x+1, y=cur.y, parent=i})
                visited[cur.y][cur.x+1] = true
            end
            if cur.y ~= 1 and not visited[cur.y-1][cur.x] and not self.collisions[cur.y-1+1][cur.x+1]  then
                table.insert(neighbors, {x=cur.x, y=cur.y-1, parent=i})
                visited[cur.y-1][cur.x] = true
            end
            if cur.y < #self.collisions-1  and not visited[cur.y+1][cur.x]  and not self.collisions[cur.y+1+1][cur.x+1] then
                table.insert(neighbors, {x=cur.x, y=cur.y+1, parent=i})
                visited[cur.y+1][cur.x] = true
            end
            while #neighbors ~= 0 do
                local index = math.random(#neighbors)
                table.insert(queue, neighbors[index])
                table.remove(neighbors, index)
            end
        end
        return nil
    end
}

return TileMap;

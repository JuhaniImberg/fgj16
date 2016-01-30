vector = require "hump.vector"

helpers = require "helpers"
tileset = require "defaulttileset"
TM = require "tilemap"

EditorCommander = require "editorcommander"


local editor = {}

function editor:init()
    map_layer_0 = {}
    for line in io.lines("map-layer-0.data") do
        table.insert(map_layer_0, line)
    end
    map_layer_1 = {}
    for line in io.lines("map-layer-1.data") do
        table.insert(map_layer_1, line)
    end

    self.tm_layer_0 = TM(tileset, map_layer_0, 3)
    self.tm_layer_1 = TM(tileset, map_layer_1, 3)
    self.layers = {self.tm_layer_0, self.tm_layer_1}
    self.commander = EditorCommander(vector(48, 27 * 24),
                                     self.layers)
end

function editor:update(dt)
    for i, tm in ipairs(self.layers) do
        tm:update(dt)
    end
    self.commander:update(dt, self)
end

function editor:draw()
    for i, tm in ipairs(self.layers) do
        tm:draw(dt)
    end
    self.commander:draw()
end

function editor:joystickadded(joystick)
    self.commander:setJoystick(joystick)
end

function editor:save()
    for i, tm in ipairs(self.layers) do
        print("Saving map-layer-" .. (i-1) .. ".data")
        local f = io.open("map-layer-" .. (i-1) .. ".data", "w")
        for y=1, #tm.map do
            local line = tm.map[y]
            for x=1, #tm.map[y] do
                f:write(tm.map[y][x])
            end
            f:write("\n")
        end
        f:close()
    end
end

function editor:keyreleased(key)
    if key == "space" then
        self:save()
    end
    if key == "return" then
        self.commander.selected_tm = self.commander.selected_tm + 1
        self.commander:updateSelectedTM()
    end

    if key == "left" then
        self.layers[1].visible = not self.layers[1].visible
    end
    if key == "right" then
        self.layers[2].visible = not self.layers[2].visible
    end

    if love.keyboard.isDown("lshift") then
        key = key:upper()
    end

    for i, info in ipairs(self.commander.tm.tileset.tiles) do
        if key == info.char then
            self.commander.selected = i
            self.commander:updateTileInfo()
            return
        end
    end
end

function editor:mousemoved(x, y)
    self.commander.pos.x = x - 12
    self.commander.pos.y = y - 12
    if love.mouse.isDown(1) then
        self.commander:place()
    end
end

function editor:wheelmoved(x,y)
    self.commander.selected = self.commander.selected+y
    self.commander:updateTileInfo()
end

function editor:mousepressed(x, y, button)
    self.commander.pos.x = x - 12
    self.commander.pos.y = y - 12
    if button == 1 then
        self.commander:place()
    end
    if button == 2 then
        self.commander.selected_tm = self.commander.selected_tm + 1
        self.commander:updateSelectedTM()
    end
end

return editor

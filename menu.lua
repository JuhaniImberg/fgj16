Gamestate = require "hump.gamestate"

helpers = require "helpers"
game = require "game"
editor = require "editor"
intro_hero = require "intro_hero"

menu = {}

function menu:init()
    self.selection = {
        {"Play Game", helpers.bind(self, "playGame")},
        {"Map Editor", helpers.bind(self, "mapEditor")}
    }
    self.music = love.audio.newSource( "sound/menu.ogg" )
    self.music:setLooping(true)
    self.font_size = 24
    self.padding = 4
    self.roles = {"hero", "commander"}
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 72),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
end

function menu:enter()
    self.selected = 1
    love.audio.play(self.music)
end

function menu:draw()
    local width, height = love.graphics.getDimensions()
    local offset = 200
    width = width / 2

    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("hero, commander", 0, 30, width, "center")

    love.graphics.setFont(self.fonts[2])
    for i, sele in ipairs(self.selection) do
        love.graphics.setColor(255, 255, 255)
        if i == self.selected then
            love.graphics.rectangle("fill", 0, offset + i * (self.font_size + self.padding), width, self.font_size + self.padding)
            love.graphics.setColor(0, 0, 0)
        end
        love.graphics.print(sele[1], 20, offset + i * (self.font_size + self.padding) - math.floor(self.padding/3*4))
    end

    love.graphics.setColor(255, 255, 255)
    love.graphics.print("Connected controllers", width + self.font_size, self.font_size)

    local joysticks = love.joystick.getJoysticks()
    for i, joystick in ipairs(joysticks) do
        love.graphics.print(i .. ": " .. joystick:getName() .. " as " .. self.roles[i], width + 40, self.font_size + i * self.font_size)
    end


        love.graphics.print("Credits", 20, 400)
        love.graphics.print("Juhani Imberg", 40, 400+self.font_size)
        love.graphics.print("Code", 300, 400+self.font_size)
        love.graphics.print("Nicklas Ahlskog", 40, 400+2*self.font_size)
        love.graphics.print("Code", 300, 400+2*self.font_size)
        love.graphics.print("Esa Niemi", 40, 400+3*self.font_size)
        love.graphics.print("Graphics", 300, 400+3*self.font_size)
        love.graphics.print("Jaakko Hannikainen", 40, 400+4*self.font_size)
        love.graphics.print("Sounds", 300, 400+4*self.font_size)
        love.graphics.print("Allan Palmu", 40, 400+5*self.font_size)
        love.graphics.print("Design", 300, 400+5*self.font_size)
end

function menu:up()
    self.selected = math.max(1, self.selected - 1)
end

function menu:down()
    self.selected = math.min(#self.selection, self.selected + 1)
end

function menu:select()
    self.selection[self.selected][2]()
end

function menu:playGame()
    love.audio.stop(self.music)
    Gamestate.switch(intro_hero)
end

function menu:mapEditor()
    love.audio.stop(self.music)
    Gamestate.switch(editor)
end

function menu:credits()

end

function menu:keyreleased(key)
    if key == "up" then
        self:up()
    end
    if key == "down" then
        self:down()
    end
    if key == "space" or key == "return" then
        self:select()
    end
end

function menu:gamepadpressed(joystick, button)
    if button == "dpup" then
        self:up()
    end
    if button == "dpdown" then
        self:down()
    end
    if button == "a" then
        self:select()
    end
end

return menu

Gamestate = require "hump.gamestate"

pregame = require "pregame"
itemlist = require "itemlist"

story_hero = {}

function story_hero:init()
    self.font_size = 28
    self.padding = 4
    self.fonts = {
        love.graphics.newFont("PixAntiqua.ttf", 48),
        love.graphics.newFont("PixAntiqua.ttf", self.font_size),
    }
    itemlist:init()
    itemlist:genRandomItemList(8,6)
end

function story_hero:draw()
    local width, height = love.graphics.getDimensions()

    love.graphics.setFont(self.fonts[1])
    love.graphics.setColor(255, 255, 255)
    love.graphics.printf("Greetings, our honored Commander!", 0, 0, width, "center")
    love.graphics.setFont(self.fonts[2])
    love.graphics.printf(("The Elders have decided to finally migrate our people from this dying world. To accomplish this, a sacred teleportation ritual has to be performed. Its ingredients are scattered over the remains of this world and need to be gathered to the ritual site in time. You, the leader of a mighty army, were chosen to do this. But watch out for the \"Hero\". This arrogant youth is so attached to his own delusions that he might unknowingly doom us all by destroying the artefacts and slaughtering his own people sent to gather them. \nWith the stars aligned as they are now, we need 4 of these 6: \nA %s, a %s, a %s, a %s, a %s, and a %s. \n\n Move your cursor with the left stick, send out troops with A, command troops to move with X.\n\nPress any key to continue."):format(itemlist.items[1].itype.name,itemlist.items[2].itype.name,itemlist.items[3].itype.name,itemlist.items[4].itype.name,itemlist.items[5].itype.name,itemlist.items[6].itype.name), 0, 120, width, "center")

end

function story_hero:next()
    Gamestate.switch(pregame)
end

function story_hero:keyreleased(key)
    self:next()
end

function story_hero:gamepadpressed(joystick, button)
    self:next()
end

return story_hero

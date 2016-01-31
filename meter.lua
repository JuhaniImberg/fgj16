Class = require "hump.class"

Meter = Class{
    init = function(self, name, pos, width, image, quad, iwidth, frames, valuer)
        self.pos = pos
        self.width = width
        self.height = 32
        self.valuer = valuer
        self.image = image
        self.quad = quad
        self.iwidth = iwidth
        self.frames = frames
    end,
    draw = function(self)
        local val = self.valuer()
        self.quad:setViewport(self.iwidth * (math.floor(love.timer.getTime()) % self.frames), 0, self.iwidth, self.iwidth)
        love.graphics.setColor(0, 0, 0, 120)
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
        love.graphics.setColor(255, 255, 255, 255)
        love.graphics.draw(self.image, self.quad, self.pos.x, self.pos.y, 0, (9*3)/self.iwidth, (9*3)/self.iwidth)
        love.graphics.print("x " .. val, self.pos.x + 32, self.pos.y - 8)
    end
}

hp_meter = Meter("hp",
                 vector(0, 0),
                 72,
                 love.graphics.newImage("graphics/heart.png"),
                 love.graphics.newQuad(9 * 0, 0, 9, 9, 36, 9),
                 9,
                 4,
                 nil)

pool_meter = Meter("pool",
                   vector(53 * 24 - 72, 0),
                   72,
                   love.graphics.newImage("graphics/elf.png"),
                   love.graphics.newQuad(18 * 0, 0, 18, 18, 54, 18),
                   18,
                   3,
                   nil)
return {
    hp = hp_meter,
    pool = pool_meter
}

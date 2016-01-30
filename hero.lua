vector = require "hump.vector"

CollidingEntity = require "collidingentity"

Hero = Class{
    __includes = CollidingEntity,
    init = function(self, pos)
        CollidingEntity.init(self, pos, 18, 18)
        self.image = love.graphics.newImage("graphics/hero1.png")
        self.quad = love.graphics.newQuad(0, 0, 18, 18, self.image:getWidth(), self.image:getHeight())
        self.joystick = nil
        self.flipped = false
        self.image_range = {1, 5}
    end,
    setJoystick = function(self, joystick)
        self.joystick = joystick
    end,
    update = function(self, dt, collfn, game)
        self:checkRekt(game)
        local time = love.timer.getTime()
        local image_ind = (math.floor(4*time)) % (self.image_range[2] - self.image_range[1]) + self.image_range[1]
        self.quad:setViewport(image_ind * 18, 0, 18, 18)

        if not self.joystick then
            return
        end

        if self.joystick:isGamepadDown("a") then
            self:dropItem()
        end

        x_axis, y_axis = self.joystick:getAxes()
        axis = vector(x_axis, y_axis)

        if axis:len() > 0.1 then
            self:move(axis, dt, collfn)

            if math.abs(axis.x) > math.abs(axis.y) then
                self.image_range = {2, 6}
                self.flipped = axis.x < 0
            else
                self.flipped = false
                if axis.y < 0 then
                    self.image_range = {6, 10}
                else
                    self.image_range = {10, 14}
                end
            end
        end

    end,
    draw = function(self)
        self:drawColor()
        love.graphics.draw(self.image,
                           self.quad,
                           math.floor(self.pos.x + 0.5 - (self.flipped and -18 or 0)),
                           math.floor(self.pos.y + 0.5),
                           0,
                           (self.flipped and -1 or 1),
                           1)
    end,
    gettingRekt = function(self)
        if not self.joystick then
            return
        end

        self.joystick:setVibration(1, 1, self.hurt_time)
    end,
}

return Hero

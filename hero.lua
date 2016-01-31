vector = require "hump.vector"

CollidingEntity = require "collidingentity"
Projectile = require "projectile"

Hero = Class{
    __includes = CollidingEntity,
    hero = true,
    init = function(self, pos)
        CollidingEntity.init(self, pos, 18, 18)
        self.image = love.graphics.newImage("graphics/hero1.png")
        self.quad = love.graphics.newQuad(0, 0, 18, 18, self.image:getWidth(), self.image:getHeight())
        self.joystick = nil
        self.flipped = false
        self.image_range = {1, 5}
        self.maxhp = self.hp
        self.last_heal = 0
        self.heal_cd = 20
    end,
    setJoystick = function(self, joystick)
        self.joystick = joystick
    end,
    update = function(self, dt, collfn, game)
        if self:checkRekt(game) then
            return
        end
        local time = love.timer.getTime()
        local image_ind = (math.floor(4*time)) % (self.image_range[2] - self.image_range[1]) + self.image_range[1]
        self.quad:setViewport(image_ind * 18, 0, 18, 18)

        if self.hp < self.maxhp and self.last_heal + self.heal_cd < love.timer.getTime() then
            self.hp = self.hp + 1
            self.last_heal = love.timer.getTime()
        end

        if not self.joystick then
            return
        end

        local x_axis_1, y_axis_1, _, x_axis_2, y_axis_2 = self.joystick:getAxes()
        local axis_1 = vector(x_axis_1, y_axis_1)
        local axis_2 = vector(x_axis_2, y_axis_2)

        if self.last_fire + self.fire_cd < love.timer.getTime() and axis_2:len() > 0.4 then
            self.last_fire = love.timer.getTime()
            game:fire(Projectile(self:middlepoint(), axis_2:normalized(), "unit"))
        end

        if self.joystick:isGamepadDown("a") then
            self:dropItem()
        end

        if axis_1:len() > 0.1 then
            self:move(axis_1, dt, collfn)

            if math.abs(axis_1.x) > math.abs(axis_1.y) then
                self.image_range = {2, 6}
                self.flipped = axis_1.x < 0
            else
                self.flipped = false
                if axis_1.y < 0 then
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

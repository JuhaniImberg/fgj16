vector = require "hump.vector"

Entity = require "entity"

Hero = Class{
    __includes = Entity,
    init = function(self, pos)
        Entity.init(self, pos, 16, 16)
        self.joystick = nil
    end,
    setJoystick = function(self, joystick)
        self.joystick = joystick
    end,
    update = function(self, dt, collfn)
        if not self.joystick then
            return
        end

        if self.joystick:isGamepadDown("a") then
            self:dropItem()
        end

        x_axis, y_axis = self.joystick:getAxes()
        axis = vector(x_axis, y_axis)

        if axis:len() > 0.1 then
            local oldpos = self.pos:clone()
            self.pos = self.pos + (axis * dt * self.speed)
            if collfn(self) then
                self.pos = oldpos
            end
        end

    end,
    draw = function(self)
        if self.carrying then
            love.graphics.setColor(200, 0, 0)
        else
            love.graphics.setColor(255, 0, 0)
        end
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
    end
}

return Hero

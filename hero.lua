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
    update = function(self, dt)
        if not self.joystick then
            return
        end
        x_axis, y_axis = self.joystick:getAxes()
        axis = vector(x_axis, y_axis)

        if axis:len() > 0.1 then
            self.pos = self.pos + (axis * dt * self.speed)
        end

    end,
    draw = function(self)
        love.graphics.setColor(255, 0, 0)
        love.graphics.rectangle("fill", self.pos.x, self.pos.y, self.width, self.height)
    end
}

return Hero

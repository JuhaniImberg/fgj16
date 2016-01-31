vector = require "hump.vector"
Class = require "hump.class"


Commander = Class{
    init = function(self, pos)
        self.pos = pos
        self.width = 24
        self.height = 24
        self.joystick = nil
        self.speed = 200
    end,
    setJoystick = function(self, joystick)
        self.joystick = joystick
    end,
    update = function(self, dt, game)
        if not self.joystick then
            return
        end

        local x_axis, y_axis = self.joystick:getAxes()
        local axis = vector(x_axis, y_axis)
        if axis:len() > 0.1 then
            self.pos = self.pos + (dt * self.speed * axis)
            self.pos.x = math.max(0, math.min(24 * 52, self.pos.x))
            self.pos.y = math.max(0, math.min(24 * 29, self.pos.y))
        end
    end,
    draw = function(self)
        if math.floor(love.timer.getTime()*2) % 2 == 0 then
            love.graphics.setColor(0, 0, 0)
        else
            love.graphics.setColor(255, 255, 255, 255)
        end

        local rpos = self.pos:clone()
        rpos.x = math.floor(rpos.x / 24 + 0.5) * 24
        rpos.y = math.floor(rpos.y / 24 + 0.5) * 24
        love.graphics.setLineWidth(3)
        love.graphics.line(rpos.x, rpos.y,
                           rpos.x + self.width, rpos.y,
                           rpos.x + self.width, rpos.y + self.height,
                           rpos.x, rpos.y + self.height,
                           rpos.x, rpos.y)
    end

}

return Commander

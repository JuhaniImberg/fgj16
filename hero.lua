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

        local steps = math.floor(self.speed*dt + 1)
        local step = (self.speed*dt)/steps

        for i=1, steps do

            if axis:len() > 0.1 then
                self.pos.y = self.pos.y + (axis * step).y
                local xcol, ycol = collfn(self)

                if ycol then
                    self.pos.y = math.floor(self.pos.y/24)*24
                    if axis.y < 0 then
                        self.pos.y = self.pos.y + 24
                    else
                        self.pos.y = self.pos.y + 7
                    end
                end
                self.pos.x = self.pos.x + (axis * step).x
                local xcol, ycol = collfn(self)
                if xcol then
                    self.pos.x = math.floor(self.pos.x/24)*24
                    if axis.x < 0 then
                        self.pos.x = self.pos.x + 24
                    else
                        self.pos.x = self.pos.x + 7
                    end
                end
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

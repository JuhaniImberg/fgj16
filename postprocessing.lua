local pp = {}

local mainCanvas

function pp:init()
    mainCanvas = love.graphics.newCanvas(1280,720)
end

function pp:getMainCanvas()
    return mainCanvas
end

function pp:draw()
    love.graphics.setColor(255, 255, 255)
    local hscale = love.graphics.getWidth()/1280
    local vscale = love.graphics.getHeight()/720
    local scale = hscale
    if vscale < hscale then
        scale = vscale
    end
    love.graphics.draw(mainCanvas, 0, 0, 0, scale, scale, 0 ,0)
end

return pp

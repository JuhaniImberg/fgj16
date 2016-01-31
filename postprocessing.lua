local pp = {}

local mainCanvas
local bgc
local fgc
local uc
local fading = 255

local fg_shadow_shader, dark_corner_shader

function load_shaders()
    local pixelcode = [[
        extern vec3 metas[4];

        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {

            vec2 off = vec2(0.002, -0.003);

            vec4 texcolor = 0.01*Texel(texture, texture_coords-3*off)
                            + 0.3*Texel(texture, texture_coords-2*off)
                            + 0.7*Texel(texture, texture_coords-off)
                            + Texel(texture, texture_coords);

            float v =  (texcolor/(1+(0.7+0.5+0.3))).w;
            return vec4(0.3,0.3,0.3,v);
        }
    ]]
    local pixelcode2 = [[
        extern vec3 metas[4];

        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
        {

            vec2 off = vec2(0.002, -0.003);

            vec4 texcolor = Texel(texture, texture_coords);

            float f = 1;//0.5+clamp(clamp(texture_coords.x*6,0,5)*clamp(texture_coords.y*6,0,5),0,1)*0.5;

            return f*texcolor;
        }
    ]]

    local vertexcode = [[
        vec4 position( mat4 transform_projection, vec4 vertex_position )
        {
            return transform_projection * vertex_position;
        }
    ]]

    fg_shadow_shader = love.graphics.newShader(pixelcode, vertexcode)
    dark_corner_shader = love.graphics.newShader(pixelcode2, vertexcode)
end

function pp:init()
    mainCanvas = love.graphics.newCanvas(24*53,720)
    bgc = love.graphics.newCanvas(24*53,720)
    bgc:setFilter("nearest","nearest")
    fgc = love.graphics.newCanvas(24*53,720)
    fgc:setFilter("nearest","nearest")
    uc = love.graphics.newCanvas(24*53,720)
    uc:setFilter("nearest","nearest")
    load_shaders()
end

function pp:getMainCanvas()
    return mainCanvas
end

function pp:getBGCanvas()
    return bgc
end

function pp:getFGCanvas()
    return fgc
end

function pp:getUnitCanvas()
    return uc
end

function pp:setFading(value)
    fading = value
end

function pp:draw()
    love.graphics.setColor(255, 255, 255)

    love.graphics.setCanvas(mainCanvas)
    love.graphics.draw(bgc)
    love.graphics.setShader(fg_shadow_shader)
    love.graphics.draw(fgc)
    love.graphics.setShader()
    love.graphics.draw(fgc)

    love.graphics.setShader(fg_shadow_shader)
    love.graphics.draw(uc)
    love.graphics.setShader()
    love.graphics.draw(uc)


    local hscale = love.graphics.getWidth()/(24*53)
    local vscale = love.graphics.getHeight()/720
    local scale = hscale
    if vscale < hscale then
        scale = vscale
    end
    love.graphics.setCanvas()
        love.graphics.setColor(fading, fading, fading)

    love.graphics.setShader(dark_corner_shader)
    love.graphics.draw(mainCanvas, 0, 0, 0, scale, scale, 0 ,0)
    love.graphics.setShader()
end

return pp

--[[
    general tilemap functions
    horray

    mostly for use with game.lua (the most complicated file)
]]
tilemap = {}

tilemap.width = 0
tilemap.height = 0
tilemap.map = {{}}

tilemap.init = function(w, h)
    tilemap.width = w
    tilemap.height = h
    for i=0, w, 1 do
        tilemap.map[i] = {}
        for j=0, h, 1 do
            tilemap.map[i][j] = {type=0, color={255, 255, 255}}
        end
    end
    tile1 = love.graphics.newImage("gfx/tile.png")
end

tilemap.get = function(x, y)
    --failsafe
    if x < 0 then x = 0 end
    if y < 0 then y = 0 end
    if x > tilemap.width - 1 then x = tilemap.width - 1 end
    if y > tilemap.height - 1 then y = tilemap.height - 1 end
    return tilemap.map[x][y]
end

tilemap.set = function(x, y, data)
    --failsafe
    if x < 0 then x = 0 end
    if y < 0 then y = 0 end
    if x > tilemap.width - 1 then x = tilemap.width - 1 end
    if y > tilemap.height - 1 then y = tilemap.height - 1 end
    tilemap.map[x][y] = data
    
end

tilemap.draw = function(x, y)
    local tw = 10
    local th = 10
    
    for i=0, #tilemap.map-1, 1 do
        for j=0, #tilemap.map[i]-1, 1 do
            local t = tilemap.map[i][j]
            
            
            love.graphics.setColor(t.color)
            if t.type ~= 0 then
                love.graphics.rectangle("fill", i*tw+x, j*th+y, tw, th)
                love.graphics.draw(tile1, i*tw+x, j*th+y)
            else
                love.graphics.setColor({0.9, 0.9, 0.9})
                love.graphics.rectangle("line", i*tw+x+3, j*th+y+3, tw-5, th-5)
            end
        end
    end
    love.graphics.setColor({0, 0, 0})
    love.graphics.rectangle("line", x, y, tw*tilemap.width, th*tilemap.height)
end



return tilemap
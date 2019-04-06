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
end

tilemap.get = function(x, y)
    return tilemap.map[x][y]
end

tilemap.set = function(x, y, data)
    tilemap.map[x][y] = data
    
end

tilemap.draw = function(x, y, tw, th)
    for i=0, #tilemap.map-1, 1 do
        for j=0, #tilemap.map[i]-1, 1 do
            local t = tilemap.map[i][j]
            love.graphics.setColor({0, 0, 0})
            love.graphics.rectangle("line", i*tw+x, j*th+y, tw, th)
            love.graphics.setColor(t.color)
            if t.type ~= 0 then
                love.graphics.rectangle("fill", i*tw+x, j*th+y, tw, th)
            end
        end
    end
end



return tilemap
tilemap = {}

local map = {{}}

tilemap.init = function(w, h)
    for i=0, w, 1 do
        map[i] = {}
        for j=0, h, 1 do
            map[i][j] = {type=0, color={255, 255, 255}}
        end
    end
end

tilemap.get = function(x, y)
    return map[x][y]
end

tilemap.set = function(x, y, data)
    map[x][y] = data
end

tilemap.draw = function(x, y, tw, th)
    for i=0, #map-1, 1 do
        for j=0, #map[i]-1, 1 do
            local t = map[i][j]
            love.graphics.setColor(t.color)
            if t.type ~= 0 then
                love.graphics.rectangle("fill", i*tw, j*th, tw, th)
            end
        end
    end
end

return tilemap

Gravity = {}


local tilemap = require 'tilemap'

function loop()
    local ac = 0

    for i = 0, tilemap.width - 1 do 
        for j = 0, tilemap.height - 2 do
            if tilemap.get(i, j).type == 1 and tilemap.get(i,j+1).type == 0 then
                local p = tilemap.get(i,j)
                tilemap.set(i, j, {type=0, color={0, 0, 0}})
                tilemap.set(i, j+1, p)
                ac = ac + 1
            end

        end
    end
   
    return ac

end

Gravity.fall = function()
    repeat 
        local AC = loop()
    until AC == 0 
    loop()
    
end

return Gravity
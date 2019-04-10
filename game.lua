--[[
    welcome to game.lua!
    this is where the games algorithims are stored in
    this is where most of the errors and bugs happen
    make sure to use the console!  
]]
game = {}
local tilemap = require 'tilemap'
game.cp = {} --this stores the players current piece (a matrix)
game.cpX = 0
game.cpY = 0
game.colors = {{255, 0, 0}, {0, 255, 0}, {0, 0, 255}, {0, 255, 255}} --table of piece colors
game.moveTimer = 20 --timer that when reaches 0, it moves the piece down and resets

--size of the pieces
local pw = 2
local ph = 1

game.newPiece = function()
    game.cpX = 0
    game.cpY = 0
    
    for i=0, pw-1, 1 do
        for j=0, ph-1, 1 do
            game.cp[i][j] = {type=2, color=game.colors[love.math.random(1, #game.colors)]}
        end
    end
end

game.initFirstPiece = function()
    for i=0, pw-1, 1 do
        game.cp[i] = {}
        for j=0, ph-1, 1 do
            game.cp[i][j] = {type=2, color=game.colors[love.math.random(1, #game.colors)]}
            tilemap.set(i, j, game.cp[i][j])
        end
    end

end

game.movePiece = function(x, y) --move piece by x and y + check collision
    
    for i=0, #game.cp, 1 do --should be the x
        for j=0, #game.cp[i], 1 do --should be the y
            tilemap.set(i + game.cpX, j + game.cpY, {type=0, color={0, 0, 0}}) --blank out current location
        end
    end
    --we check collision here and change vars accordingly
    cr = moveAndCheckCollision(x, y)
    game.cpX = cr.x
    game.cpY = cr.y
    
    for i=0, #game.cp, 1 do --should be the x
        for j=0, #game.cp[i], 1 do --should be the y
            if cr.cp then
                game.cp[i][j].type = 1
                tilemap.set(i + game.cpX, j + game.cpY, game.cp[i][j])
            else
                tilemap.set(i + game.cpX, j + game.cpY, game.cp[i][j]) --put the piece at the new location (as still current piece)
            end
        end
    end
    if cr.cp then
        game.newPiece()
    end
end

game.rotatePiece = function(ccw) --rotates a piece. set 'ccw' to True if rotating ccw
    
    if ccw then
        
    else
       
    end
    
end

function moveAndCheckCollision(cbmx, cbmy)
    --[[
    returns coords if the piece cant be inside another tile or out of bounds
    ]]
    local canPlace = false


    
    if game.cpY == 24 - #game.cp then
        canPlace = true
        cbmx = 0
        cbmy = 0
    end
    if game.cpX == 0 and cbmx < 0 then
        cbmx = 0
    end
    if game.cpX + pw == tilemap.width and cbmx > 0 then
        cbmx = 0
    end

    return {x=game.cpX+cbmx, y=game.cpY+cbmy, cp=canPlace}

end

return game
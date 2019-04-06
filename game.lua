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
local ph = 2

game.newPiece = function() --creates a new piece, should fire after a piece is placed
    for i=0, pw-1, 1 do
        game.cp[i] = {}
        for j=0, ph-1, 1 do
            game.cp[i][j] = {type=2, color=game.colors[love.math.random(1, #game.colors)]}
            tilemap.set(i, j, game.cp[i][j])
        end
    end
end

game.movePiece = function(x, y) --move piece by x and y + check collision
    for i=0, pw-1, 1 do --should be the x
        for j=0, ph-1, 1 do --should be the y
            tilemap.set(i + game.cpX, j + game.cpY, {type=0, color={0, 0, 0}}) --blank out current location
        end
    end
    --we check collision here and change vars accordingly
    cr = checkCollision(game.cpX + x, game.cpY + y)
    game.cpX = cr.x --change vars
    game.cpY = cr.y
    
    for i=0, pw-1, 1 do --should be the x
        for j=0, ph-1, 1 do --should be the y
            tilemap.set(i + game.cpX, j + game.cpY, game.cp[i][j]) --put the piece at the new location
        end
    end
end

game.rotatePiece = function(ccw) --rotates a piece. set 'ccw' to True if rotating counter-clockwise

end

function checkCollision(px, py, pl, pw)
    --[[
    returns coords if the piece cant be inside another tile or out of bounds
    prams:
    px - the x of collision box
    py - the y of collision box
    pl - length of collision box
    pw - width of collision box
    ]]
    
    --for now just return new pos
    return {x=px, y=py}

end

return game
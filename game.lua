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
game.cpDir = 0 --0=down,1=left,2=right,3=up
game.gamestate = 0 --0=title,1=options,2=game,3=pause,4=game end
game.score = 0
--size of the pieces
local pw = 2
local ph = 1
local t1
local t2
local cpDirTable = {{{}}}
game.newPiece = function()
    game.cpX = 0
    game.cpY = 0
    game.cpDir = 2
    t1 = {type=2, color=game.colors[love.math.random(1, #game.colors)]}
    t2 = {type=2, color=game.colors[love.math.random(1, #game.colors)]}
    cpDirTable[0] = {{t2},{t1}} --down
    cpDirTable[1] = {{t1, t2}} --left
    cpDirTable[2] = {{t1},{t2}} --right
    cpDirTable[3] = {{t2, t1}} --up
    game.cpDir = 2
    game.cp = cpDirTable[game.cpDir] --set it to right for start
    if #game.cp == 0 then error("oh no") end
end

game.initGame = function()
    game.newPiece()

end

game.movePiece = function(x, y) --move piece by x and y + check collision
    tilemapSetPiece(true)
    
    --we check collision here and change vars accordingly
    cr = moveAndCheckCollision(x, y)
    game.cpX = cr.x
    game.cpY = cr.y
    if cr.cp then
        t1.type = 1
        t2.type = 1
    end
    tilemapSetPiece(t1, t2)
    if cr.cp then
        local x
        local y
        for x=0, tilemap.width - 1, 1 do
            for y=0, tilemap.height-1, 1 do
                checkAndRemoveMatches(x, y)
            end
        end
        game.newPiece()
    end
end

game.rotatePiece = function(ccw) --rotates a piece. set 'ccw' to True if rotating ccw
    tilemapSetPiece(true)
    local origDir = game.cpDir
    local t2x
    local t2y
    if ccw then
        if game.cpDir == 0 then
        game.cpDir = 2
        t2x = 1
        t2y = 0
        elseif game.cpDir == 1 then
        game.cpDir = 0
        t2x = 0
        t2y = -1
        elseif game.cpDir == 2 then
        game.cpDir = 3
        t2x = 0
        t2y = 1
        elseif game.cpDir == 3 then
        game.cpDir = 1
        t2x = -1
        t2y = 0
        end
    else
        if game.cpDir == 0 then
        game.cpDir = 1
        t2x = -1
        t2y = 0
        elseif game.cpDir == 1 then
        game.cpDir = 3
        t2x = 0
        t2y = 1
        elseif game.cpDir == 2 then
        game.cpDir = 0
        t2x = 0
        t2y = -1
        elseif game.cpDir == 3 then
        game.cpDir = 2
        t2x = 1
        t2y = 0
        end
    end
    if (tilemap.get(game.cpX + t2x, game.cpY + t2y).type ~= 0) or (game.cpX + t2x < 0) or (game.cpX + t2x > tilemap.width - 1) then game.cpDir = origDir end
    game.cp = cpDirTable[game.cpDir]
    tilemapSetPiece(t1, t2)
end

function moveAndCheckCollision(cbmx, cbmy)
    --[[
    returns coords if the piece cant be inside another tile or out of bounds
    ]]
    local canPlace = false
    local go
    local wo
    local t2x --offsets
    local t2y
    
    if game.cpDir == 0 then
        go = 0
        wo = 0
        t2x = 0
        t2y = -1
    elseif game.cpDir == 1 then
        go = 0
        wo = 0
        t2x = -1
        t2y = 0
    elseif game.cpDir == 2 then
        go = 0
        wo = -1
        t2x = 1
        t2y = 0
    elseif game.cpDir == 3 then
        go = -1
        wo = 0
        t2x = 0
        t2y = 1
    end
    
    if (game.cpY == tilemap.height - 1 + go) or (tilemap.get(game.cpX, game.cpY + 1).type == 1) or (tilemap.get(game.cpX + t2x, game.cpY + t2y + 1).type == 1) then
        canPlace = true
        cbmx = 0
        cbmy = 0
    end
    if cbmx < 0 and ((game.cpX == 0) or (tilemap.get(game.cpX - 1, game.cpY).type == 1) or (tilemap.get(game.cpX + t2x - 1, game.cpY + t2y).type == 1)) then --left movement
        cbmx = 0
    end
    if cbmx > 0 and ((game.cpX == tilemap.width - 1 + wo) or (tilemap.get(game.cpX + 1, game.cpY).type == 1) or (tilemap.get(game.cpX + t2x + 1, game.cpY + t2y).type == 1)) then --right movement
        cbmx = 0
    end

    

    return {x=game.cpX+cbmx, y=game.cpY+cbmy, cp=canPlace}

end

function tilemapSetPiece(tp1, tp2)
    if tp1 == true then
        tp1 = {type=0, color={0, 0, 0}}
        tp2 = {type=0, color={0, 0, 0}}
    end
    if game.cpDir == 0 then
        tilemap.set(game.cpX, game.cpY, tp1)
        tilemap.set(game.cpX, game.cpY-1, tp2)
    elseif game.cpDir == 1 then
        tilemap.set(game.cpX, game.cpY, tp1)
        tilemap.set(game.cpX-1, game.cpY, tp2)
    elseif game.cpDir == 2 then
        tilemap.set(game.cpX, game.cpY, tp1)
        tilemap.set(game.cpX+1, game.cpY, tp2)
    elseif game.cpDir == 3 then
        tilemap.set(game.cpX, game.cpY, tp1)
        tilemap.set(game.cpX, game.cpY+1, tp2)
    end
end

--------------------------------------------tile check functions----------------------------------------------------------------------------------------------------------


function checkAndRemoveMatches(tx, ty)
    local delX = {}
    local delY = {}
    --up
    local ctx = tx
    local cty = ty
    local same = true
    local sameCounter = 0
    local tempDelX = {}
    local tempDelY = {}
    repeat
        
        if tilemap.get(ctx, cty).color == tilemap.get(tx, ty).color then
            table.insert(tempDelX, ctx)
            table.insert(tempDelY, cty)
            sameCounter = sameCounter + 1
            same = true
            cty = cty - 1
            game.score = game.score + 1
        else
            same = false
        end
        
    until (not same) or cty < 0
    if sameCounter > 2 then
        for k,v in pairs(tempDelX) do delX[#delX + k] = v end
        for k,v in pairs(tempDelY) do delY[#delY + k] = v end
    end







    clearMatching(delX, delY)--do at end of func
end

function clearMatching(delX, delY)
    for i=0, #delX-1, 1 do
        tilemap.set(delX[i], delY[i], {type=0, color={0, 0, 0}})
    end
end


return game
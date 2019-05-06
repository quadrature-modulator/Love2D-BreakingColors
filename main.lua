--[[
    welcome to the main file!

    control key:
    (a) = k
    (b) = j
    (x) = i
    (y) = u
    dpad is arrow keys
    start = enter
    select = space
    MENU is esc
    shift is nul (not avalible for use)
    using shift allows for more options
    shift will change almost every button

    todo:
    
        -menu
        -idk
]]
--vars for cool stuff

--get the files we need
local tilemap = require 'tilemap'
local game = require 'game'
--{type=0, color={}} --this is the structure of a tile object
--types include: 0=air, 1=solid tile, 2=current piece tile, etc.
tilemap.init(18, 24)
local horTimer = 0
local hasController = false
function love.load()
    min_dt = 1/30
   next_time = love.timer.getTime()
    love.window.setMode(320, 240, {resizable=false, highdpi=true})
    love.window.setTitle("breaking colors window")
    love.keyboard.setKeyRepeat(false)
    --tilemap.set(0, 0, {type=1, color=game.colors[love.math.random(0, #game.colors)]})
    --tilemap.set(0, 2, {type=1, color=game.colors[love.math.random(0, #game.colors)]})
    game.initGame()
    local gameFont = love.graphics.newFont("DETERMINATION.TTF", 16)
    love.graphics.setFont(gameFont)
    local joysticks = love.joystick.getJoysticks()
    gameJoy = joysticks[1]
    if gameJoy then hasController = true end
    

end



function love.update(dt)
    next_time = next_time + min_dt
    if love.keyboard.isDown("escape") then
        love.event.quit() --for the gameshell menu button
    end
    if game.moveTimer == 0 then
        if love.keyboard.isDown('down') then game.moveTimer = 2 else game.moveTimer = game.moveTReset end
        if hasController then if gameJoy:isGamepadDown("dpdown") then game.moveTimer = 2 else game.moveTimer = game.moveTReset end end
        game.movePiece(0, 1)
    else
        game.moveTimer = game.moveTimer - 1
    end

    if horTimer == 0 then
        if love.keyboard.isDown('left') then
            game.movePiece(-1, 0)
            horTimer = 3
        elseif love.keyboard.isDown('right') then
            game.movePiece(1, 0)
            horTimer = 3
        end
        if hasController then
            if gameJoy:isGamepadDown("dpleft") then
                game.movePiece(-1, 0)
                horTimer = 3
            elseif gameJoy:isGamepadDown("dpright") then
                game.movePiece(1, 0)
                horTimer = 3
            end
        end
    else
        horTimer = horTimer - 1
    end

    if game.vibrateT > 0 then
        game.vibrateT = game.vibrateT - 1
        if hasController then gameJoy:setVibration(1, 1) end
    else
        if hasController then gameJoy:setVibration(0, 0) end
    end

    if game.pfT > 0 then
        game.pfT = game.pfT - 1
        game.checkAndFall()
    end
    
end

function love.draw()
    love.graphics.setBackgroundColor({255, 255, 255})
    love.graphics.setColor({0, 0, 0})
    love.graphics.print("score: "..game.score, 210, 20)
    love.graphics.print("level: "..game.lvl, 210, 40)
    love.graphics.print("FPS: "..tostring(love.timer.getFPS( )), 210, 60)
    tilemap.draw(20, 0, 10, 10)

    local cur_time = love.timer.getTime()
   if next_time <= cur_time then
      next_time = cur_time
      return
   end
   love.timer.sleep(next_time - cur_time)
end

function love.keypressed(key)
    if key == "right" or key == "left" then
        horTimer = 0
    elseif key == "down" then
        game.moveTimer = 0
    end
    if key == "k" then
        game.rotatePiece(true)
    elseif key == "j" then
        game.rotatePiece(false)
    end

end

function love.gamepadpressed(joystick, btn)
    if btn == "dpright" or btn == "dpleft" then
        horTimer = 0
    elseif btn == "dpdown" then
        game.moveTimer = 0
    end
    if btn == "a" then
        game.rotatePiece(true)
    elseif btn == "b" then
        game.rotatePiece(false)
    end

end

function drawTitle()


end
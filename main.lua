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
]]
--vars for cool stuff
local tilemap = require 'tilemap'
local game = require 'game'
--{type=0, color={}} --this is the structure of a tile object
--types include: 0=air, 1=solid tile, 2=current piece tile, etc.
tilemap.init(12, 6)

function love.load()
    love.window.setMode(320, 240, {resizable=false, highdpi=true})
    love.window.setTitle("breaking colors window")
    love.keyboard.setKeyRepeat(false)
    tilemap.set(0, 0, {type=1, color=game.colors[love.math.random(0, #game.colors)]})
    tilemap.set(0, 2, {type=1, color=game.colors[love.math.random(0, #game.colors)]})
end

function love.update()
    if love.keyboard.isDown("escape") then
        love.event.quit() --for the gameshell menu button
    end
end

function love.draw()
    love.graphics.setBackgroundColor({255, 255, 255})
    love.graphics.setColor({0, 0, 0})
    love.graphics.print("breaking colors hi", 0, 120)
    tilemap.draw(20, 20, 20, 20)
end
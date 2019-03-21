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

--{type=0, color={}} --this is the structure of a tile object

tilemap.init(3, 3)

function love.load()
    love.window.setMode(320, 240, {resizable=false, highdpi=true})
    love.window.setTitle("breaking colors window")
    love.keyboard.setKeyRepeat(false)
    tilemap.set(0, 0, {type=1, color={255, 0, 0}})
    tilemap.set(0, 2, {type=1, color={255, 0, 0}})
end

function love.update()
    if love.keyboard.isDown("escape") then
        love.event.quit() --for the gameshell menu button
    end
end

function love.draw()
    love.graphics.print("breaking colors", 0, 120)
    tilemap.draw(20, 20, 10, 10)
end
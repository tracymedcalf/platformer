Gamestate = require 'hump.gamestate'
Class = require 'hump.class'
local Entities = require 'entities.Entities'
local Entity = require 'entities.Entity'

local Level = Class{
__include = Gamestate,
init = function(self)
    Entities:enter()
end;
}

--local Player = require 'entities.player'
--local Ground = require 'entities.ground'
--[[
player = nil
world = nil
--]]
function Level:update(dt)
    if love.keyboard.isDown('p') then
        Gamestate.switch(pause)
    end
	Entities:update(dt)
end

function Level:draw()
	Entities:draw()
end

return Level

bump = require 'bump'
Gamestate = require 'hump.gamestate'
local Class = require 'hump.class'
local Entities = require 'entities.Entities'
--[[local Entity = require 'entities.Entity'

local Player = require 'entities.player'
local Ground = require 'entities.ground'
--]]
local Level = Class{
__include = Gamestate,
}

function Level:update(dt)
	Entities:update(dt)
end

function Level:draw()
	Entities:draw()
end
return Level

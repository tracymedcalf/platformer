--[[bump = require 'bump'
Gamestate = require 'hump.gamestate'--]]
local Class = require 'hump.class'
local Entities = require 'entities.Entities'
--local Entity = require 'entities.Entity'

local Player = require 'entities.player'
local Ground = require 'entities.ground'
local Level = require 'gamestates.Level'
local gameLevel2 = Class{
__includes = Level
}

player = nil
world = nil

function gameLevel2:enter()
    self.Entities = Entities
	world = bump.newWorld(16)
	Entities:enter()
	player = Player(world,16,16)
	local ground_0 = Ground(world,110,400,'assets/green_grass.png',3)
	local ground_1 = Ground(world,0,300,'assets/dirt.png',2)
    
	Entities:addMany({player,ground_0,ground_1})

end

return gameLevel2

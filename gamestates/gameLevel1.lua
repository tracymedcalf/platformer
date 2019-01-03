--[[bump = require 'bump'
Gamestate = require 'hump.gamestate'--]]
local Class = require 'hump.class'
local Entities = require 'entities.Entities'
--local Entity = require 'entities.Entity'

local Player = require 'entities.player'
local Ground = require 'entities.ground'
local Level = require 'gamestates.Level'
local Door = require 'entities.Door'
local gameLevel2 = require 'gamestates.gameLevel2'

local gameLevel1 = Class{
__includes = Level
}

player = nil
world = nil

function gameLevel1:enter()
    self.Entities = Entities
	world = bump.newWorld(16)
	Entities:enter()
	player = Player(world,16,16)
	local ground_0 = Ground(world,120,360,'assets/green_grass.png',2)
	local ground_1 = Ground(world,0,448,'assets/dirt.png',2)
    local door_1 = Door(world,10,448,gameLevel2)
	Entities:addMany({ground_0,ground_1,door_1,player})
end

return gameLevel1

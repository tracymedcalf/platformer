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
local Building = require 'entities.Building'

local gameLevel1 = Class{
__includes = Level
}

player = nil
world = nil
---[[
function genBuildings(world)
    local bottom = 1000
    local buildings = {Building(world,-10,1000,1000,10)}
    math.randomseed(os.time())
    local w = 100
    for i=1,10,1 do
        local top = bottom
        for j=1,10,1 do
            local x = i * w
            local h = math.random(40,140)
            table.insert(buildings,Building(world,x,top-h,w,h))
            top = top - h
        end
    end
    return buildings
end--]]
--[[
function genBuildings(world)
    local buildings = {Building(world,-10,1000,1000,10)}
    for 
    math.randomseed(os.time())
    --]]

function gameLevel1:enter()
    self.Entities = Entities
	world = bump.newWorld(16)
	Entities:enter()
	player = Player(world,16,16)
	Entities:add(player)
    Entities.camera = player.camera
    Entities:addMany(genBuildings(world))
end

return gameLevel1

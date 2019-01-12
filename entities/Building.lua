local Class = require 'hump.class'
local Entity = require 'entities.Entity'

local Building = Class{
	__includes = Entity
}

function Building:init(world,x,y,w,h)
	Entity.init(self,world,x,y,w,h)
    self.color = {math.random(),math.random(),math.random()}
    self.isBuilding = true
	self.world:add(self,self:getRect())
end

function Building:draw()
    love.graphics.setColor(self.color)
	love.graphics.rectangle('fill',self:getRect())
end

return Building

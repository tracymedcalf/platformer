local Class = require 'hump.class'

local Entity = Class{}

function Entity:init(world,x,y,w,h)
	self.world = world
	self.x = x
	self.y = y
	self.w = w
	self.h = h
end

function Entity:getRect()
	return self.x, self.y, self.w, self.h
end

function Entity:draw()
--Nothing yet
end

function Entity:update(dt)
end

return Entity

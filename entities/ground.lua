local Class = require 'hump.class'
local Entity = require 'entities.Entity'

local Ground = Class{
	__includes = Entity
}

function Ground:init(world,x,y,imgPath,scaleX)
    self.img = love.graphics.newImage(imgPath)
	Entity.init(self,world,x,y,self.img:getWidth() * scaleX,self.img:getHeight())
    self.scaleX = scaleX
	self.world:add(self,self:getRect())
end

function Ground:draw()
	--love.graphics.rectangle('fill',self:getRect())
    love.graphics.draw(self.img,self.x,self.y,nil,self.scaleX,1)
end

return Ground

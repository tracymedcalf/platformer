local Class = require 'hump.class'
local Entity = require 'entities.Entity'

local Door = Class {
__includes = Entity
}

-- parameters : x and y are the coordinates of the bottom-left corner of the door
function Door:init(world,x,y,level)
    local img = love.graphics.newImage('assets/door.png')
    Entity.init(self,world,x)
    self.scale = .5
    self.w = img:getWidth() * self.scale
    self.h = img:getHeight() * self.scale
    self.y = y - self.h
    self.img = img
    self.level = level
    self.world:add(self,self:getRect())
    self.isDoor = true
end

function Door:draw()
    --love.graphics.color('purple')
    --love.graphics.rectangle('fill',self:getRect())
    love.graphics.draw(self.img,self.x,self.y,nil,self.scale,self.scale)
end

function Door:action()
    Gamestate.switch(self.level)
end

return Door

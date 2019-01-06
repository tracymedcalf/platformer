local Class = require 'hump.class'
local Entity = require 'entities.Entity'

local enemy = Class{
	__includes = Entity, -- enemy class inherits Entity
    height = 20,
    width = 20,
}

function enemy:getHeight()
    return self.height
end

function enemy:getWidth()
    return self.width
end

function enemy:init(world,x,y)
	
	Entity.init(self,world,x,y,self:getWidth(),self:getHeight())

	self.xVelocity = 0
	self.yVelocity = 0
	self.acc = 100
	self.maxSpeed = 600
	self.friction = 20
	self.gravity = 80

	self.isJumping = false
	self.isGrounded = false
	self.hasReachedMax = false
	self.jumpAcc = 500
	self.jumpMaxSpeed = 11

	self.world:add(self,self:getRect())
end
--[[
function enemy:collisionFilter(other)
	local x,y,w,h = self.world:getRect(other)
	local :enemyBottom = self.y + self.h
	local otherBottom = y + h

	if enemyBottom <= y then
		return 'slide'
	end
end--]]

function enemy:collisionFilter(other)
    if other.isDoor then
        return 'cross'
    end
    return 'slide'
end

function enemy:update(dt)
	local prevX, prevY = self.x, self.y
	
	-- Friction
	self.xVelocity = self.xVelocity * (1 - math.min(dt * self.friction, 1))
	self.yVelocity = self.yVelocity * (1 - math.min(dt * self.friction, 1))

	-- Gravity
	self.yVelocity = self.yVelocity + self.gravity * dt

	if love.keyboard.isDown('left','a') and self.xVelocity > -self.maxSpeed then
		self.xVelocity = self.xVelocity - self.acc * dt
	elseif love.keyboard.isDown('right','d') and self.xVelocity < self.maxSpeed then
		self.xVelocity = self.xVelocity + self.acc * dt
	end

	-- Jumping
	if love.keyboard.isDown('up','w') then
        if -self.yVelocity < self.jumpMaxSpeed and not self.hasReachedMax then
		    self.yVelocity = self.yVelocity - self.jumpAcc * dt
	    elseif math.abs(self.yVelocity) >= self.jumpMaxSpeed then
		    self.hasReachedMax = true
        end
	    self.isGrounded = false
	end

    local goalX = self.x + self.xVelocity
    local goalY = self.y + self.yVelocity

    self.x, self.y, collisions, len = self.world:move(self,goalX,goalY,self.collisionFilter)
    for _, coll in ipairs(collisions) do
        if coll.other.isDoor then
            coll.other:action()
		elseif coll.touch.y > goalY then -- We touched below
			self.hasReachedMax = true
			self.isGrounded = false
		elseif coll.normal.y < 0 then
			self.hasReachedMax = false
			self.isGrounded = true
		end
	end--]]
end

function enemy:draw()
	love.graphics.rectangle('fill',self.x,self.y,self:getHeight(),self:getWidth())
    --love.graphics.draw(self.img,self.x,self.y)
end

return enemy


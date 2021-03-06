
local Class = require 'hump.class'
local Entity = require 'entities.Entity'
local Camera = require 'hump.camera'
local WizardMode = require 'playerModes.wizard'

local player = Class{
	__includes = Entity, -- player class inherits Entity
    height = 20,
    width = 20,
}

function player:getHeight()
    return self.height
end

function player:getWidth()
    return self.width
end

function player:init(world,x,y)
	--self.img = love.graphics.newImage('/assets/character_block.png')
	
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
    self.camera = Camera(self.x,self.y)
    self.climbing = false
    self.climbMode = false
    self.modeFilter = WizardMode.collisionFilter
end
--[[
function player:collisionFilter(other)
	local x,y,w,h = self.world:getRect(other)
	local :playerBottom = self.y + self.h
	local otherBottom = y + h

	if playerBottom <= y then
		return 'slide'
	end
end--]]

function player:cameraUpdate()
    self.camera:lookAt(self.x,self.y)
end
function player:collisionFilter(other) 
    if other.isDoor then
        return 'cross'
    end
    return self.modeFilter(self,other)
end

function player:climbingUpdate(dt)
    if love.keyboard.isDown('up','w') then
        self.yVelocity = self.yVelocity - self.acc * dt
    elseif love.keyboard.isDown('down','s') then
        self.yVelocity = self.yVelocity + self.acc * dt
    end
end

function player:update(dt)
	local prevX, prevY = self.x, self.y
	
	-- Friction
	self.xVelocity = self.xVelocity * (1 - math.min(dt * self.friction, 1))
	self.yVelocity = self.yVelocity * (1 - math.min(dt * self.friction, 1))

    if love.keyboard.isDown('left','a') and self.xVelocity > -self.maxSpeed then
        self.xVelocity = self.xVelocity - self.acc * dt
    elseif love.keyboard.isDown('right','d') and self.xVelocity < self.maxSpeed then
        self.xVelocity = self.xVelocity + self.acc * dt
    end

    if not self.isClimbing then
        -- Gravity
        self.yVelocity = self.yVelocity + self.gravity * dt
        -- Jumping
        if love.keyboard.isDown('up','w') then
            if -self.yVelocity < self.jumpMaxSpeed and not self.hasReachedMax then
                self.yVelocity = self.yVelocity - self.jumpAcc * dt
            elseif math.abs(self.yVelocity) >= self.jumpMaxSpeed then
                self.hasReachedMax = true
            end
            self.isGrounded = false
        end
	else
        self:climbingUpdate(dt)
        self.isClimbing = false
    end

    if love.keyboard.isDown('e') then
        self.climbMode = not self.climbMode
    end
    local goalX = self.x + self.xVelocity
    local goalY = self.y + self.yVelocity
    self.x, self.y, collisions, len = self.world:move(self,goalX,goalY,self.collisionFilter)
    for _, coll in ipairs(collisions) do
        if coll.other.isDoor then
            coll.other:action()
		elseif self.climbMode and coll.normal.x ~= 0 then -- coll.other.isBuilding
            self.isClimbing = true
        --[[elseif coll.touch.y > goalY then -- We touched below
			self.hasReachedMax = true
			self.isGrounded = false--]]
		elseif coll.normal.y < 0 then
			self.hasReachedMax = false
			self.isGrounded = true
		end
	end--]]
    self:cameraUpdate()
end

function player:draw()
	love.graphics.rectangle('fill',self.x,self.y,self:getHeight(),self:getWidth())
    --love.graphics.draw(self.img,self.x,self.y)
end

return player


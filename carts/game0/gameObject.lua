-- Filename: gameObject.lua
-- Purpose: GameObject functions
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2
local collision = require("collision") -- collisionMapRect
local globals = require("globals") -- pixelsPerUnit

-- Class definition
gameObject = 
{
	-- Transform
	position = vec2:new(0,0),
	extents = vec2:new(0.3,0.4),
	
	-- sprite
	sprite = 0,
	frameCurr = 0,
	frameCount = 2,
	flipX = false,
	
	-- physics
	velocity = vec2:new(0,0),
	inertia = 0.9,
	gravity = 0.1,
	
	-- collision
	grounded = false,
	t = 0,
	bounce = 1,
}

-- Constructor
function gameObject:new(go)
	go = go or {}
	setmetatable(go, self)
	self.__index = self
	return go
end

-- Move and animate an object
function gameObject:update(objects)
	-- ANIMATION
	-- Flip if going other direction
	if abs(self.velocity.x) > 0.1 then
		if self.velocity.x < 0 and not self.flipX then 
			self.flipX = true
		elseif self.velocity.x > 0 and self.flipX then 
			self.flipX = false
		end
	end
	
	-- PHYSICS
	-- only move object along x
	-- if the resulting position
	-- will not overlap with an object
	if not collision.checkAll(self, vec2:new(self.velocity.x, 0), objects) then
		self.position.x += self.velocity.x
	else   
		-- otherwise bounce
		self.velocity.x *= -self.bounce
		--sfx(2)
	end

	-- ditto for y
	--[[if not collision.checkAll(self, vec2:new(0, self.velocity.y), objects) then
		self.position.y += self.velocity.y
	else
		self.velocity.y *= -self.bounce
	end

	-- apply inertia
	-- set dx,dy to zero if you
	-- don't want inertia
	self.velocity = self.velocity:times(self.inertia)
	
	-- apply gravity
	self.grounded = collision.checkMapPoint(vec2:new(self.position.x, self.position.y + 0.5))
	if not grounded then
		self.velocity.y += self.gravity
	end]]
	
	-- y movement
	local yMove = vec2:new(0, self.velocity.y)
	local halfExtent = self.extents.x / 2
	local quarterExtent = self.extents.x / 4
	local nudgeDown = 0.01
	local nudgeUp = 0.05
	
	-- going up
	if (self.velocity.y < 0) then
		local leftUp = self.position:plus(vec2:new(-halfExtent, -1))
		local rightUp = self.position:plus(vec2:new(halfExtent, -1))
		
		if collision.checkMapPoint(rightUp:plus(yMove)) or 
				collision.checkMapPoint(leftUp:plus(yMove)) 
		then
			-- Stop y movement
			self.velocity.y = 0
	 
			-- search up for collision point
			while not collision.checkMapPoint(leftUp) or
				collision.checkMapPoint(rightUp)
			do
				self.position.y -= nudgeDown
				leftUp = self.position:plus(vec2:new(-halfExtent, -1))
				rightUp = self.position:plus(vec2:new(halfExtent, -1))
			end

		else
			self.position.y += self.velocity.y
		end
	-- going down
	else
		local leftDown = self.position:plus(vec2:new(-halfExtent, 0))
		local rightDown = self.position:plus(vec2:new(halfExtent, 0))
	
		if collision.checkMapPoint(rightDown:plus(yMove)) or 
				collision.checkMapPoint(leftDown:plus(yMove)) 
		then
			-- bounce
			if self.bounce > 0 and self.velocity.y > halfExtent then
				self.velocity.y -= self.bounce
			else
				self.grounded = true
				self.velocity.y = 0
			end

		--snap down
		while not collision.checkMapPoint(leftDown) or
			collision.checkMapPoint(rightDown)
		do 
			self.position.y += nudgeUp
			leftDown = self.position:plus(vec2:new(-halfExtent, 0))
			rightDown = self.position:plus(vec2:new(halfExtent, 0))
		end

		--pop up even if bouncing
		while collision.checkMapPoint(leftDown:plus(vec2:new(0, -quarterExtent))) do
			self.position.y -= nudgeUp
			leftDown = self.position:plus(vec2:new(-halfExtent, 0))
		end
		while collision.checkMapPoint(rightDown:plus(vec2:new(0, -quarterExtent))) do
			self.position.y -= nudgeUp
			rightDown = self.position:plus(vec2:new(halfExtent, 0))
		end

		else
			self.position.y += self.velocity.y 
		end
	end
 
	-- gravity and friction
	self.velocity.y += self.gravity
	self.velocity.y *= self.inertia + 0.05

	-- x friction
	if self.grounded then
		self.velocity.x *= self.inertia - 0.1
	else
		self.velocity.x *= self.inertia
	end
	
	-- Timer???
	self.t += 1
	
end

-- draw object's sprite
function gameObject:draw()
	local spritePosition = self.position:minus(vec2:new(0.5,0.5)):times(globals.pixelsPerUnit)
	spr(self.sprite + self.frameCurr, spritePosition.x, spritePosition.y, 1, 1, self.flipX)
end

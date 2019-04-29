-- Filename: gameObject.lua
-- Purpose: GameObject functions
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2
collision = require("collision") -- collisionMapRect
globals = require("globals") -- pixelsPerUnit

-- Class definition
gameObject = 
{
	-- Transform
	position = vec2:new(0,0),
	extents = vec2:new(0.4,0.4),
	
	-- sprite
	sprite = 0,
	frameCurr = 0,
	frameCount = 2,
	flipX = false,
	
	-- physics
	velocity = vec2:new(0,0),
	inertia = 0.9,
	gravity = 0.05,
	
	-- collision
	flags = 
	{
		bottom = false,
		top = false,
		left = false,
		right = false,
	},
	grounded = false,
	t = 0,
	bounce = 0.8,
	ghostMap = false,
	ghostObjects = false,
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
	
	-- MOVEMENT
	if not self.ghostMap and self.ghostObjects then
		self:checkCollisions(objects)
	else
		self.position = self.position:plus(self.velocity)
	end
	
	-- FORCES
	-- Gravity
	self.velocity.y += self.gravity
	
	if not self.grounded then
		-- Inertia
		self.velocity = self.velocity:times(self.inertia)
	else
		-- Inertia: more on ground
		self.velocity = self.velocity:times(self.inertia - 0.2)
	end
	
	-- Timer???
	self.t += 1
	
end

-- draw object's sprite
function gameObject:draw()
	local spritePosition = self.position:times(globals.pixelsPerUnit)
	spr(self.sprite + self.frameCurr, spritePosition.x, spritePosition.y, 1, 1, self.flipX)
end

-- check and resolve collisions
function gameObject:checkCollisions(objects)
	-- Initialize variables
	local nudgeAmount = 0.55
	local locations =
	{
		bottom = 0,
		top = 0,
		left = 0,
		right = 0,
	}
	
	-- JUMP
	if collision.checkMapRect(self.position:plus(vec2:new(0,nudgeAmount)), self.extents, locations)
	then
		self.grounded = true
	else
		self.grounded = false
	end

	-- COLLISIONS
	self.flags.bottom = false
	self.flags.top = false
	self.flags.left = false
	self.flags.right = false
	
	-- only move object along x if the resulting position will not overlap with an object
	local velocityX = vec2:new(self.velocity.x, 0)
	if collision.checkAll(self, velocityX, locations, objects) then
		if self.velocity.x < 0 then
			self.flags.left = true
			self.position.x = locations.left + self.extents.x + nudgeAmount
		elseif self.velocity.x > 0 then
			self.flags.right = true
			self.position.x = locations.right - self.extents.x - nudgeAmount
		end
	
		-- otherwise bounce
		self.velocity.x *= -self.bounce
		--sfx(2)
	else
		-- Move x as normal
		self.position.x += self.velocity.x
	end

	-- Ditto for y
	local velocityY = vec2:new(0, self.velocity.y)
	if collision.checkAll(self, velocityY, locations, objects) then
		if self.velocity.y < 0 then
			self.flags.top = true
			self.position.y = locations.top + self.extents.y + nudgeAmount
		elseif self.velocity.y > 0 then
			self.flags.bottom = true
			self.grounded = true
			self.position.y = locations.bottom - self.extents.y - nudgeAmount
		end
	
		self.velocity.y *= -self.bounce
	else
		-- Move y as normal
		self.position.y += self.velocity.y
	end
end

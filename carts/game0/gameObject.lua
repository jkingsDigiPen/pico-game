-- Filename: gameObject.lua
-- Purpose: GameObject functions
-- Author: Jeremy Kings

-- Dependencies
--require("vec2") -- vec2
local collision = require("collision") -- collisionMapRect

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
	
	-- physics
	velocity = vec2:new(0,0),
	inertia = 0.6,
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
function gameObject:Update(objects)
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
	if not collision.checkAll(self, vec2:new(0, self.velocity.y), objects) then
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
	end

	-- ANIMATION
	-- advance one frame every
	-- time actor moves 1/4 of
	-- a tile
	self.frameCurr += abs(self.velocity.x) * 4
	self.frameCurr += abs(self.velocity.y) * 4
	self.frameCurr %= self.frameCount
	
	-- What is this for???
	self.t += 1
	
end

-- draw object's sprite
function gameObject:Draw()
	local spritePosition = self.position:times(8):minus(vec2:new(4,4))
	spr(self.sprite + self.frameCurr, spritePosition.x, spritePosition.y)
end

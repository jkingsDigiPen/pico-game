-- Filename: gameObject.lua
-- Purpose: GameObject functions
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2
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
	inertia = 0.99,
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
	bounce = 0.8,
	ghostMap = false,
	ghostObjects = false,
	
	-- behavior
	onUpdate = function(go) end,
	onCollision = function(go) end,
	objectType = 0,
	timer = 0,
}

-- Constructor
function gameObject:new(go)
	go = go or {}
	setmetatable(go, self)
	self.__index = self
	return go
end

-- Move and animate an object
function gameObject:update()
	-- Call update function
	self.onUpdate(self)
	-- Increase timer
	self.timer += 1
end

-- draw object's sprite
function gameObject:draw()
	local spritePosition = self.position:times(globals.pixelsPerUnit)
	spr(self.sprite + self.frameCurr, spritePosition.x, spritePosition.y, 1, 1, self.flipX)
end

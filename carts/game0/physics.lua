-- Filename: physics.lua
-- Purpose: Movement of Objects
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2
collision = require("collision") -- checkAll, checkMapRect

local physics = {}

function physics.update(objects)
	-- Apply forces
	for go in all(objects) do
		-- Gravity
		go.velocity.y += go.gravity
		-- Inertia
		go.velocity = go.velocity:times(go.inertia)
	end

	-- Check for collisions
	for go in all(objects) do
		physics.checkCollision(go, objects)
	end
	
	-- Publish results
	foreach(objects, physics.publishResults)
end

-- Check for horizontal and vertical collision
function physics.checkCollision(go, objects)
	-- Initialize variables
	local locations =
	{
		bottom = 0,
		top = 0,
		left = 0,
		right = 0,
	}
	
	-- JUMP
	if collision.checkMapRect(go.position:plus(vec2:new(0,nudgeAmount)), go.extents, locations)
	then
		go.grounded = true
	else
		go.grounded = false
	end

	-- COLLISIONS
	go.flags.bottom = false
	go.flags.top = false
	go.flags.left = false
	go.flags.right = false
	
	physics.checkCollisionY(go, locations, objects)
	physics.checkCollisionX(go, locations, objects)
end

-- Check for horizontal collision
function physics.checkCollisionX(go, locations, objects)
	local nudgeAmount = 0.55
	local velocityX = vec2:new(go.velocity.x, 0)
	
	-- If moving horizontally would overlap with an object
	if collision.checkAll(go, velocityX, locations, objects) then
		-- Mark flags and adjust x position and x velocity accordingly
		if go.velocity.x < 0 then
			go.flags.left = true
			go.position.x = locations.left + go.extents.x + nudgeAmount
		elseif go.velocity.x > 0 then
			go.flags.right = true
			go.position.x = locations.right - go.extents.x - nudgeAmount
		end
	
		-- otherwise bounce
		go.velocity.x *= -go.bounce
		--sfx(2)
	end
end

-- Check for vertical collision
function physics.checkCollisionY(go, locations, objects)
	local nudgeAmount = 0.55
	local velocityY = vec2:new(0, go.velocity.y)
	
	-- If moving vertically would overlap with an object
	if collision.checkAll(go, velocityY, locations, objects) then
		-- Mark flags and adjust y position and y velocity accordingly
		if go.velocity.y < 0 then
			go.flags.top = true
			go.position.y = locations.top + go.extents.y + nudgeAmount
		elseif go.velocity.y > 0 then
			go.flags.bottom = true
			go.grounded = true
			go.position.y = locations.bottom - go.extents.y - nudgeAmount
		end
	
		go.velocity.y *= -go.bounce
	end
end

-- Update object position
function physics.publishResults(go)
	if go.flags.bottom or go.flags.top or go.flags.right or go.flags.left then
		go.onCollision()
	end
	
	go.position = go.position:plus(go.velocity)
end

return physics

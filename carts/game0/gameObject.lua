-- Filename: gameObject.lua
-- Purpose: GameObject functions
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2
collision = require("collision") -- collisionMapRect

-- Construct a game object
function gameObjectCreate(position, sprite)
	go = {}
	
	-- Transform
	go.position = position
	go.extents = vec2(0.4,0.4)
	
	-- sprite
	go.sprite = sprite
	go.frameCurr = 0
	go.frameCount = 2
	
	-- physics
	go.velocity = vec2(0,0)
	go.inertia = 0.6
	go.gravity = 0.1
	
	-- collision
	go.t = 0
	go.bounce = 1
	
	-- add to manager
	add(objects, go)

	return go
end

-- Move and animate an object
function gameObjectUpdate(go, objects)
	-- PHYSICS
	-- only move object along x
	-- if the resulting position
	-- will not overlap with an object
	if not collision.checkAll(go, vec2(go.velocity.x, 0), objects) then
		go.position.x += go.velocity.x
	else   
		-- otherwise bounce
		go.velocity.x *= -go.bounce
		sfx(2)
	end

	-- ditto for y
	if not collision.checkAll(go, vec2(0, go.velocity.y), objects) then
		go.position.y += go.velocity.y
	else
		go.velocity.y *= -go.bounce
	end

	-- apply inertia
	-- set dx,dy to zero if you
	-- don't want inertia
	go.velocity = vec2Scale(go.velocity, go.inertia)
	
	-- apply gravity
	go.velocity.y += go.gravity

	-- ANIMATION
	-- advance one frame every
	-- time actor moves 1/4 of
	-- a tile
	go.frameCurr += abs(go.velocity.x) * 4
	go.frameCurr += abs(go.velocity.y) * 4
	go.frameCurr %= go.frameCount

	go.t += 1
 
end

-- draw object's sprite
function gameObjectDraw(go)
	local position = vec2Sub(vec2Scale(go.position, 8), vec2(4,4))
	spr(go.sprite + go.frameCurr, position.x, position.y)
end

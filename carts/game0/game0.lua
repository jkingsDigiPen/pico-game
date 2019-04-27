-- Filename: game0
-- Purpose: Game logic
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- create
manager = require("manager") -- update, draw
keys = require("input") -- keys

-- Player controller
function playerUpdate()

	-- how fast to accelerate
	local accel = 0.1
	if (btn(keys.left)) then 
		pl.velocity.x -= accel 
	end
	if (btn(keys.right)) then 
		pl.velocity.x += accel 
	end
	if (btn(keys.up)) then 
		pl.velocity.y -= accel 
	end
	if (btn(keys.down)) then 
		pl.velocity.y += accel 
	end

	-- play a sound if moving
	-- (every 4 ticks)
	if (abs(pl.velocity.x) + abs(pl.velocity.y) > 0.1 and (pl.t % 4) == 0) then
		sfx(1)
	end
	
end

-- Initialize
function _init()
	-- make player top left
	pl = gameObjectCreate(vec2(2, 2), 17)

	-- make a bouncy ball
	local ball = gameObjectCreate(vec2(8.5, 7.5), 33)
	ball.velocity = vec2(0.05, 0.1)
	ball.inertia = 0.5

	-- make non-bouncy ball
	local ball = gameObjectCreate(vec2(7, 5), 49)
	ball.velocity = vec2(-0.1, 0.15)
	ball.inertia=1
	ball.bounce = 0.8

	-- tiny guy
	local a = gameObjectCreate(vec2(7, 5), 5)
	a.frameCount = 4
	a.velocity = vec2(1/8,0)
	a.inertia=0.8
	
end

-- Update
function _update()
 playerUpdate()
 manager.update()
end

-- Draw
function _draw()
	cls()
	map(0,0,0,0,16,16)
	manager.draw()

	print("x "..pl.position.x, 0, 120, 7)
	print("y "..pl.position.y, 64, 120, 7)
end

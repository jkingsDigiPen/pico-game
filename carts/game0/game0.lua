-- Filename: game0
-- Purpose: Game logic
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- create
local manager = require("manager") -- update, draw
local keys = require("input") -- keys

-- Player controller
function playerUpdate()

	-- how fast to accelerate
	local accel = 0.1
	if btn(keys.left) then 
		player.velocity.x -= accel 
	end
	if btn(keys.right) then 
		player.velocity.x += accel 
	end
	
	-- jump
	local jump = -1.5
	if btnp(keys.up) and player.grounded then 
		player.velocity.y += jump
	end

	-- play a sound if moving
	-- (every 4 ticks)
	if abs(player.velocity.x) + abs(player.velocity.y) > 0.1 and (player.t % 4) == 0 then
		sfx(1)
	end
	
end

-- Initialize
function _init()
	-- make player top left
	player = gameObject:new
	{
		position = vec2:new(2, 2), 
		sprite = 17,
	}
	manager.add(player)

	-- make a bouncy ball
	local ball = gameObject:new
	{
		position = vec2:new(8.5, 7.5), 
		sprite = 33,
		velocity = vec2:new(0.05, 0.1),
		inertia = 0.5,
	}
	manager.add(ball)

	-- make non-bouncy ball
	local ball = gameObject:new
	{
		position = vec2:new(7, 5), 
		sprite = 49,
		velocity = vec2:new(-0.1, 0.15),
		inertia = 1,
		bounce = 0.8,
	}
	manager.add(ball)

	-- tiny guy
	local a = gameObject:new
	{
		position = vec2:new(8, 5), 
		sprite = 5,
		frameCount = 4,
		velocity = vec2:new(1/8,0),
		inertia = 0.8,
	}
	manager.add(a)
	
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

	print("x "..player.position.x, 0, 120, 7)
	print("y "..player.position.y, 64, 120, 7)
end

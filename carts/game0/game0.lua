-- Filename: game0
-- Purpose: Game logic
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- create
local manager = require("manager") -- update, draw
local keys = require("input") -- keys
local globals = require("globals") -- pixelsPerUnit, viewportWidth, mapWidth, mapHeight

-- Player controller
function playerUpdate()

	-- How fast to pick up speed
	local accel = 0.1
	-- Less control in air
	if not player.grounded then 
		accel *= 0.5 
	end
	
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
	if abs(player.velocity.x) + abs(player.velocity.y) 
			> 0.1 and (player.t % 4) == 0 then
		sfx(1)
	end
	
end

function cameraUpdate()
	-- map and actors
	cam_x = mid(0, player.position.x * globals.pixelsPerUnit - (0.5) * globals.viewportWidth, 
		(globals.mapWidth - 3) * 3)

	--cam_y = mid(0,player.y*6-40,128)
	cam_y = 0
	camera (cam_x,cam_y)
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
	--[[local ball = gameObject:new
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
	manager.add(a)]]
	
end

function guiDraw()
	-- fix positions of gui elements
	camera(0, 0)
	print("x "..player.position.x, 0, 120, 7)
	print("y "..player.position.y, 64, 120, 7)
end

-- Update
function _update()
 playerUpdate()
 manager.update()
 cameraUpdate()
end

-- Draw
function _draw()
	cls()
	map(0,0,0,0, globals.mapWidth, globals.mapHeight)
	manager.draw()
	guiDraw()
end

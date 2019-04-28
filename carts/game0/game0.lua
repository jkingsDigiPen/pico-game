-- Filename: game0
-- Purpose: Game logic
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- create
manager = require("manager") -- update, draw
input = require("input") -- keys
globals = require("globals") -- pixelsPerUnit, viewportWidth, mapWidth, mapHeight

-- Player controller
function playerUpdate()
	-- MOVEMENT
	-- How fast to pick up speed
	local accel = 0.035
	-- Less control in air
	if not player.grounded then 
		accel *= 0.5 
	end
	
	if input.isHeld(input.keyCodes.left) then 
		player.velocity.x -= accel
		player.flipX = true
	end
	if input.isHeld(input.keyCodes.right) then 
		player.velocity.x += accel
		player.flipX = false
	end
	
	-- jump
	local jump = -0.8
	if input.isPressed(input.keyCodes.up) and player.grounded then 
		player.velocity.y += jump
		player.grounded = false
	end
	
	-- ANIMATION
	if player.grounded then
		-- Walking animation
		-- advance one frame every 0.5 units
		if abs(player.velocity.x) >= 0.07 then
			player.frameCurr += abs(player.velocity.x) * 2
			player.frameCurr %= player.frameCount
		-- Idle animation (advance every 32 ticks)
		elseif ((player.t % 32) == 0) then
			if(player.frameCurr == 0) then
				player.frameCurr = 2
			else
				player.frameCurr = 0
			end
		end
		
		-- play a sound if moving
		-- (every 8 ticks)
		if abs(player.velocity.x) + abs(player.velocity.y) 
				> 0.1 and (player.t % 8) == 0 then
			sfx(1)
		end
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
	input.init()

	-- make player top left
	player = gameObject:new
	{
		position = vec2:new(6, 2), 
		sprite = 17,
		bounce = 0,
	}
	manager.add(player)
	
	-- play level music
	music(0)
	
end

function guiDraw()
	-- fix positions of gui elements
	camera(0, 0)
	print("x "..player.position.x, 0, 120, 7)
	print("y "..player.position.y, 64, 120, 7)
	print("vx "..player.velocity.x, 0, 110, 7)
	print("vy "..player.velocity.y, 64, 110, 7)
end

-- Update
function _update()
	input.update()
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

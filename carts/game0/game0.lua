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
	--[[local jump = -0.8
	if input.isPressed(input.keyCodes.up) and player.grounded then 
		player.velocity.y += jump
		player.grounded = false
	end]]--
	
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
				> 0.3 and (player.t % 8) == 0 then
			sfx(1)
		end
	end
end

function cursorUpdate()
	-- MOVEMENT
	-- How fast to pick up speed
	local speed = 0.3
	local direction = vec2:new(0,0)
	if input.isHeld(input.keyCodes.left) then 
		direction.x += -1
	end
	if input.isHeld(input.keyCodes.right) then 
		direction.x += 1
	end
	if input.isHeld(input.keyCodes.up) then 
		direction.y += -1
	end
	if input.isHeld(input.keyCodes.down) then 
		direction.y += 1
	end
	
	cursor.velocity = direction:normalized():times(speed)
	
	-- ANIMATION
	if input.isHeld(input.keyCodes.action1) then
		cursor.frameCurr = 1
	else
		cursor.frameCurr = 0
	end
	
	-- Update!
	cursor:update()
end

function cameraUpdate()
	--[[cam_x = mid(globals.mapOffsetX * 4, player.position.x * globals.pixelsPerUnit - (0.5) * globals.viewportWidth, 
		(globals.mapWidth + globals.mapOffsetX - 3) * 4)]]--
  cam_y = mid(globals.mapOffsetY * 4, player.position.y * globals.pixelsPerUnit - (0.5) * globals.viewportWidth, 
		(globals.mapHeight + globals.mapOffsetY - 3) * 4)
	
	-- fixed camera x
	cam_x = (globals.mapWidth / 2.0) * globals.pixelsPerUnit - (0.5) * globals.viewportWidth
	
	camera (cam_x,cam_y)
end

-- Initialize
function _init()
	input.init()

	-- make player
	player = gameObject:new
	{
		position = vec2:new(15, 22), 
		sprite = 17,
		bounce = 0,
		ghostObjects = true,
	}
	manager.add(player)
	
	-- make cursor
	cursor = gameObject:new
	{
		position = vec2:new(17, 22),
		sprite = 70,
		ghostMap = true,
		ghostObjects = true,
		gravity = 0,
	}
	-- should be drawn on top of foreground, so don't let manager
	-- update or draw the cursor
	--manager.add(cursor)
	
	-- play level music
	music(0)
	
end

function guiDraw()
	-- fix positions of gui elements
	camera(0, 0)
	print("player_x "..player.position.x, 0, 120, 7)
	print("player_y "..player.position.y, 64, 120, 7)
	print("cursor_x "..cursor.position.x, 0, 110, 7)
	print("cursor_y "..cursor.position.y, 64, 110, 7)
end

-- Update
function _update()
	input.update()
	playerUpdate()
	cursorUpdate()
	manager.update()
end

-- Draw
function _draw()
	cls()
	
	-- background color
	camera(0, 0)
	rectfill(0,0,127,127,0)
		
	-- adjust camera to player
	cameraUpdate()
	
	-- background layer
	map(globals.mapWidth, 0, 0, globals.mapHeight * globals.pixelsPerUnit, globals.mapWidth, globals.mapHeight)
	
	-- object layer
	map(0, globals.mapHeight, 0, globals.mapHeight * globals.pixelsPerUnit, globals.mapWidth, globals.mapHeight)
	
	-- game objects
	manager.draw()
	
	-- foreground layer
	map(0, 0, 0, globals.mapHeight * globals.pixelsPerUnit, globals.mapWidth, globals.mapHeight)
	
	-- cursor object
	cursor:draw()
	
	-- gui
	guiDraw()
end

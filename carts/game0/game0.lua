-- Filename: game0
-- Purpose: Game logic
-- Author: Jeremy Kings

-- Dependencies
require("gameObject") -- create
local manager = require("manager") -- update, draw
local input = require("input") -- keys
local globals = require("globals") -- pixelsPerUnit, viewportWidth, mapWidth, mapHeight

local playerStartX = 15
local playerStartY = 22
local cursorStartX = 17
local cursorStartY = 22
local cameraPosition = vec2:new(playerStartX, playerStartY)

-- Check whether object is within the viewable area
function isOnScreen(object)
	local cameraBounds =
	{
		left = cameraPosition.x - globals.map.width / 2,
		right = cameraPosition.x + globals.map.width / 2,
		top = cameraPosition.y - globals.map.height / 2,
		bottom = cameraPosition.y + globals.map.height / 2,
	}
	
	local objectBounds = 
	{
		left = object.position.x - object.extents.x,
		right = object.position.x + object.extents.x,
		top = object.position.y - object.extents.y,
		bottom = object.position.y + object.extents.y,
	}
	
	-- Rectangle to rectangle bounds check
	if objectBounds.left > cameraBounds.right then return false end
	if objectBounds.right < cameraBounds.left then return false end
	if objectBounds.top > cameraBounds.bottom then return false end
	if objectBounds.bottom < cameraBounds.top then return false end
	
	-- All other possibilities eliminated, so object must be on screen
	return true
end

-- Create fireball
angle = 0

function fireballCreate(playerPosition, cursorPosition)
	-- Create object
	local fireball = gameObject:new
	{
		position = vec2:new(playerPosition.x, playerPosition.y), 
		sprite = globals.sprites.fireball,
		frameCount = 4,
		gravity = 0.02,
		inertia = 0.99,
		--ghostObjects = true,
		objectType = globals.objectTypes.fireballz
	}
	manager.add(fireball)

	-- Initial velocity
	local speed = 0.3
	local direction = cursorPosition:minus(playerPosition)
	
	-- Determine arc of fireball based on cursor and player
	angle = atan2(direction.x, direction.y)
	local minAngle = 0.1
	local maxAngleRight = 0.2
	if direction.x > 0 then
		if angle > 0.25 or angle < minAngle then angle = minAngle end
		angle = min(angle, maxAngleRight)
	end
	local maxAngle = 0.4
	local minAngleLeft = 0.3
	if direction.x < 0 then
		fireball.flipX = true
		if angle > maxAngle or angle < 0.25 then angle = maxAngle end
		angle = max(angle, minAngleLeft)
	end
	
	-- Set actual velocity
	direction = vec2:new(cos(angle), sin(angle))
	fireball.velocity = direction:times(speed)
end

-- Animate fireball
function fireballUpdate()
	local animTick = 5

	for object in all(manager.objects) do
		if object.objectType == globals.objectTypes.fireball then
			-- ANIMATION
			-- advance one frame every 3 ticks
			if object.timer % 3 == 0 then
				object.frameCurr += 1
				object.frameCurr %= object.frameCount
			end
			
			-- DEATH
			if not isOnScreen(object) then
				del(manager.objects, object)
			end
		end
	end
end

-- Player controller
function playerUpdate()
	-- MOVEMENT
	-- How fast to pick up speed
	local accel = 0.05
	-- Less control in air
	if not player.grounded then 
		accel *= 0.5 
	end
	
	if input.isHeld(input.keyCodes.left) and cursor.position.x < player.position.x then 
		player.velocity.x -= accel
		player.flipX = true
	elseif input.isHeld(input.keyCodes.right) and cursor.position.x > player.position.x then 
		player.velocity.x += accel
		player.flipX = false
	else
		player.velocity.x = 0
	end
	
	-- jump
	--[[local jump = -0.8
	if input.isPressed(input.keyCodes.up) and player.grounded then 
		player.velocity.y += jump
		player.grounded = false
	end]]--
	
	-- ATTACKS
	if input.isPressed(input.keyCodes.action1) then
		fireballCreate(player.position, cursor.position)
	end
	
	-- ANIMATION
	if player.grounded then
		-- Walking animation
		-- advance one frame every 0.5 units
		if abs(player.velocity.x) >= 0.07 then
			player.frameCurr += abs(player.velocity.x) * 2
			player.frameCurr %= player.frameCount
		-- Idle animation (advance every 32 ticks)
		elseif ((player.timer % 32) == 0) then
			if(player.frameCurr == 0) then
				player.frameCurr = 2
			else
				player.frameCurr = 0
			end
		end
		
		-- play a sound if moving
		-- (every 8 ticks)
		if abs(player.velocity.x) + abs(player.velocity.y) 
				> 0.3 and (player.timer % 8) == 0 then
			sfx(1)
		end
	end
end

local xMinOffset = 4
local xMaxOffset = 4
local yMinOffset = -4
local yMaxOffset = 2

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
	
	-- Clamp position to slightly less than map width
	cursor.position.x = mid(globals.map.offsetX + xMinOffset, cursor.position.x, 
		globals.map.offsetX + globals.map.width - xMaxOffset)
	-- Allow for some breathing room at top of map, less at bottom
	cursor.position.y = mid(globals.map.offsetY + yMinOffset, cursor.position.y, 
		globals.map.offsetY + globals.map.height - yMaxOffset)
end

function cameraUpdate()
	local nudge = 0.01

	-- lerp towards cursor
	cameraPosition = cameraPosition:lerp(cursor.position, 0.1)
	
	-- clamp to map
	local viewportWidthWorldHalf = (globals.viewportWidth / 2) / globals.pixelsPerUnit
	cameraPosition.x = mid(globals.map.offsetX + viewportWidthWorldHalf + xMinOffset, cameraPosition.x, 
		globals.map.offsetX + globals.map.width - viewportWidthWorldHalf - xMaxOffset + 1)
	
	-- allow for some breathing room at top of map
	cameraPosition.y = mid(globals.map.offsetY + viewportWidthWorldHalf + yMinOffset, cameraPosition.y, 
		globals.map.offsetY + globals.map.height - viewportWidthWorldHalf - yMaxOffset + 1)
	
	-- convert to pixel coords
	cam_x = cameraPosition.x * globals.pixelsPerUnit - 0.5 * globals.viewportWidth
	cam_y = cameraPosition.y * globals.pixelsPerUnit - 0.5 * globals.viewportWidth
	
	-- set camera
	camera (cam_x, cam_y)
end

-- Initialize
function _init()
	input.init()

	-- make player
	player = gameObject:new
	{
		position = vec2:new(playerStartX, playerStartY), 
		sprite = globals.sprites.player,
		bounce = 0.0,
		ghostObjects = true,
		objectType = globals.objectTypes.player,
	}
	manager.add(player)
	
	-- make cursor
	cursor = gameObject:new
	{
		position = vec2:new(cursorStartX, cursorStartY),
		sprite = globals.sprites.cursor,
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
	
	local textXStart = 0
	local textXDist = 64
	local textYStart = 120
	local textYDist = 10
	
	print("player_x "..player.position.x, textXStart, textYStart, globals.colors.white)
	print("player_y "..player.position.y, textXStart + textXDist, textYStart, globals.colors.white)
	print("cursor_x "..cursor.position.x, textXStart, textYStart - textYDist, globals.colors.white)
	print("cursor_y "..cursor.position.y, textXStart + textXDist, textYStart - textYDist, globals.colors.white)
	print("angle "..angle, textXStart, textYStart - textYDist * 2, globals.colors.white)
end

-- Update
function _update()
	input.update()
	playerUpdate()
	cursorUpdate()
	fireballUpdate()
	manager.update()
end

local transparentColor = 0
function paletteSetTransparentColor(color)
	palt(transparentColor, false)
	transparentColor = color
	palt(transparentColor, true)
end

function paletteReset()
    paletteSetTransparentColor(0)
end

-- Draw
function _draw()
	cls()
	
	-- background color
	camera(0, 0)
	rectfill(0, 0, globals.viewportWidth - 1, globals.viewportWidth - 1, 0)
		
	-- adjust camera to player
	cameraUpdate()
	
	-- background layer
	map(globals.map.width, 0, 0, (globals.map.height - 0.5) * globals.pixelsPerUnit, globals.map.width, globals.map.height)
	
	-- object layer
	--paletteSetTransparentColor(globals.colors.peach)
	map(0, globals.map.height, 0, globals.map.height * globals.pixelsPerUnit, globals.map.width, globals.map.height)
	--paletteReset() -- default transparency
	
	-- game objects
	manager.draw()
	
	-- foreground layer
	paletteSetTransparentColor(globals.colors.greenDark)
	map(0, 0, 0, globals.map.height * globals.pixelsPerUnit, globals.map.width, globals.map.height)
	paletteReset() -- default transparency
	
	-- cursor object
	cursor:draw()
	
	-- gui
	guiDraw()
end

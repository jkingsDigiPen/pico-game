-- Filename: collision.lua
-- Purpose: Collision Detection
-- Author: Jeremy Kings

-- Dependencies
require("vec2") -- vec2

local collision = {}

-- for any given point on the map, true if there is a wall
function collision.checkMapPoint(position)

	-- grab the cell value
	val = mget(position.x, position.y)

	-- check if flag 1 is set (the
	-- orange toggle button in the 
	-- sprite editor)
	return fget(val, 1)
 
end

-- Check if a rectangle overlaps with any walls)
function collision.checkMapRect(position, extents, locations)
	-- Initialize variables
	local result = false
	local infinity = 32000
	locations.left=infinity
	locations.right=-infinity
	locations.top=infinity
	locations.bottom=-infinity
	
	-- Calculate sides of rectangle
	local rectLeft = flr(position.x - extents.x + 0.5)
	local rectRight = flr(position.x + extents.x + 0.5)
	local rectTop = flr(position.y - extents.y + 0.5)
	local rectBottom = flr(position.y + extents.y + 0.5)
	
	-- Determine collision locations
  for i = rectLeft, rectRight do
		for j = rectTop, rectBottom do
			if fget(mget(i,j), 1) then
				locations.left = i < locations.left and i or locations.left
				locations.right = i > locations.right and i or locations.right
				locations.top = j < locations.top and j or locations.top
				locations.bottom = j > locations.bottom and j or locations.bottom
				result = true
			end
		end
  end
  return result
end

-- true if go will hit another
-- object after moving a specific amount
function collision.checkObject(go1, moveAmount, go2)

	local diffStart = go1.position:minus(go2.position)
	local diffEnd = go1.position:plus(moveAmount):minus(go2.position)
	local extSum = go1.extents:plus(go2.extents)
	
	if ((abs(diffEnd.x) < extSum.x) and (abs(diffEnd.y) < extSum.y)) then
		local velSum = go1.velocity:plus(go2.velocity)

		-- moving together?
		-- this allows actors to
		-- overlap initially 
		-- without sticking together    
		if (moveAmount.x != 0 and abs(diffEnd.x) < abs(diffStart.x)) then
			v = velSum.x
			go1.velocity.x = v / 2
			go2.velocity.x = v / 2
			return true 
		end

		if (moveAmount.y != 0 and abs(diffEnd.y) < abs(diffStart.y)) then
			v = velSum.y
			go1.velocity.y = v / 2
			go2.velocity.y = v / 2
			return true 
		end

		return true
	end
	
	return false
end

-- check collision against all other objects
function collision.checkObjectList(go1, moveAmount, objects)
	for go2 in all(objects) do
		if not go2.ghostObjects and not go2 == go1 and not go2.objectType == go1.objectType 
		then
			if collision.checkObject(go1, moveAmount, go2) then return true end
		end
	end
	
	return false
end

-- check map and object collisions
function collision.checkAll(go, moveAmount, locations, objects)
	local result = false

	if not go.ghostObjects then
		if collision.checkObjectList(go, moveAmount, objects) then
			result = true
		end
	end
	
	if not go.ghostMap then 
		if collision.checkMapRect(go.position:plus(moveAmount), go.extents, locations) then
			result = true
		end
	end
	
	return result
end

return collision

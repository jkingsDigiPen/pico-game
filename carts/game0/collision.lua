-- Filename: collision.lua
-- Purpose: Collision Detection, Resolution
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

-- check if a rectangle overlaps with any walls
--(only works for objects less than one tile big)
function collision.checkMapRect(position, extents)
	return
		collision.checkMapPoint(position:minus(extents)) or
		collision.checkMapPoint(vec2:new(position.x + extents.x, position.y - extents.y)) or
		collision.checkMapPoint(vec2:new(position.x - extents.x, position.y + extents.y)) or
		collision.checkMapPoint(position:plus(extents))
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
		if (go2 != go1) then
			if collision.checkObject(go1, moveAmount, go2) then
				return true
			end
		end
	end
	
	return false
end

-- check map and object collisions
function collision.checkAll(go, moveAmount, objects)
	if collision.checkMapRect(go.position:plus(moveAmount), go.extents) then
		return true 
	end
	
	return collision.checkObjectList(go, moveAmount, objects)
end

return collision
